import 'dart:io';
import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/controllers/user_controller.dart';
import 'package:followme/helpers/common/helpers.dart';
import 'package:followme/helpers/common/messages.dart';
import 'package:followme/model/session_model.dart';
import 'package:followme/screens/login_screen.dart';
import 'package:followme/utilities/providers/ProfileScreen/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class InfoDashboard extends StatefulWidget {
  const InfoDashboard(this.user, {Key? key}) : super(key: key);
  final user;

  @override
  State<InfoDashboard> createState() => _InfoDashboardState();
}

class _InfoDashboardState extends State<InfoDashboard> {
  final ImagePicker imgPicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileScreenProvider>(context);
    return Container(
        width: MediaQuery.of(context).size.width - 40,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        decoration: BoxDecoration(
            color: FollowMeColors.darkAccentColor.shade200.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Column(
              children: [
                widget.user.picture != null
                    ? Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(widget.user.picture),
                              fit: BoxFit.fill),
                        ),
                      )
                    : Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/profile_pic_placeholder.png"),
                              fit: BoxFit.fill),
                        ),
                      )
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            //Image.network(user.picture)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.displayName,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.user.email,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: FollowMeColors.darkAccentColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    onPressed: () async {
                      var selectedImage =
                          await CommonHelpers.selectImage(imgPicker);
                      if (selectedImage != null) {
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(selectedImage.path),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Do you want to upload this profile picture?",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: FollowMeColors
                                                  .darkAccentColor.shade400
                                                  .withOpacity(0.2),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel",
                                                style: TextStyle(
                                                    fontFamily: 'Pacifico',
                                                    fontSize: 12,
                                                    color: FollowMeColors
                                                        .darkAccentColor))),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: FollowMeColors
                                                  .darkAccentColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 20),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                            ),
                                            onPressed: () async {
                                              try {
                                                SessionModel session =
                                                    await SessionController
                                                        .readUserInfo();
                                                var result =
                                                    await UserController
                                                        .updateUserPicture(
                                                  selectedImage,
                                                  session.email,
                                                  session.token,
                                                );
                                                Navigator.pop(context);
                                                if (result == "expired") {
                                                  SessionController
                                                      .deleteSession();
                                                  Navigator.of(context).pushAndRemoveUntil(
                                                    // the new route
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => LoginScreen(),
                                                    ),
                                                        (Route route) => false,
                                                  );
                                                } else if (result.success !=
                                                    1) {
                                                  MessagesHandler
                                                      .showInSnackBar(
                                                          result.error,
                                                          context);
                                                } else {
                                                  MessagesHandler
                                                      .showInSnackBar(
                                                          "Success", context);
                                                  provider.infoChanged = true;
                                                }
                                              } catch (err) {
                                                MessagesHandler.showInSnackBar(
                                                    "An error occurred",
                                                    context);
                                              }
                                            },
                                            child: const Text("Confirm",
                                                style: TextStyle(
                                                    fontFamily: 'Pacifico',
                                                    fontSize: 12,
                                                    color: Colors.white)))
                                      ])
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Row(
                      children: [
                        const Text("Edit Photo",
                            style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontSize: 12,
                                color: Colors.white)),
                        const SizedBox(width: 5),
                        Image.asset("assets/icons/edit_fill.png", width: 20),
                      ],
                    )),
              ],
            )
          ],
        ));
  }
}
