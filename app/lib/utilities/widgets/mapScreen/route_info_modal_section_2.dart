import 'dart:io';

import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/controllers/routes_controller.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/helpers/common/helpers.dart';
import 'package:followme/helpers/common/messages.dart';
import 'package:followme/helpers/common/validators.dart';
import 'package:followme/model/session_model.dart';
import 'package:followme/utilities/providers/mapScreen/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RouteInfoModalSection2 extends StatefulWidget {
  RouteInfoModalSection2(this.routes, {Key? key}) : super(key: key);

  final routes;
  static final _forKey = GlobalKey();

  @override
  State<RouteInfoModalSection2> createState() => _RouteInfoModalSection2State();
}

class _RouteInfoModalSection2State extends State<RouteInfoModalSection2> {
  final ImagePicker imgPicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapScreenProvider>(context);
    final commentController = TextEditingController();
    return Container(
      child: Column(
        children: [
          Container(
              height: 200,
              child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 0, right: 20, bottom: 20, top: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.routes.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 120,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(widget.routes.images[index]),
                            fit: BoxFit.fill),
                      ),
                    );
                  })),
          SizedBox(height: 20),
          Row(
            children: [
              Text("Reviews",
                  style: TextStyle(
                    fontSize: 20,
                  ))
            ],
          ),
          provider.imageList!.isNotEmpty  ?
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => Padding(
                  padding:
                  const EdgeInsets.only(left: 0, right: 20, bottom: 20, top: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Image.file(File(provider.imageList![index].path)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  provider.removeImagesFromList(index);
                                },
                                child: Image.asset(
                                  "assets/icons/close_round_orange.png",
                                  width: 20,
                                  height: 20,
                                )),
                          ),
                        ],
                      ))),
              itemCount: provider.imageList!.length,
            ),
          ) : Container(),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Form(
                  child: TextFormField(
                    // any number you need (It works as the rows for the textarea)
                    controller: commentController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xffED7C30))),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(14),
                        hintText: "Insert a comment..."),
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  final selectedImagesList =
                  await CommonHelpers
                      .selectImages(imgPicker);
                  if (selectedImagesList != null) {
                    provider.imageList = provider.imageList! +
                        selectedImagesList;
                  }
                }, // handle your image tap here
                child: Image.asset("assets/icons/upload_img_icon.png",
                    width: 30, height: 30),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  var valErrors =
                  Validator.submitReviewFields(commentController.text);
                  if (valErrors.isNotEmpty) {
                    MessagesHandler.showInSnackBar(valErrors,context);
                    return;
                  }
                    SessionModel session = await SessionController.readUserInfo();
                    var result = await RoutesController.addReview(commentController.text,provider.imageList,widget.routes.id,session.email,session.token);
                }, // handle your image tap here
                child: Image.asset("assets/icons/send_icon.png",
                    width: 30, height: 30),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
              height: 500,
              child:
                  widget.routes.reviews!=null ?
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.routes.reviews.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: FollowMeColors.darkAccentColor.shade200
                                    .withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                    widget.routes.reviews[index].picture!=null ?
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                        image: DecorationImage(
                                            image: NetworkImage(widget.routes.reviews[index].picture),
                                            fit: BoxFit.fill),
                                      ),
                                    ):
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/profile_pic_placeholder.png"),
                                            fit: BoxFit.fill),
                                      ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.routes.reviews[index].displayName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),),
                                    widget.routes.reviews[index].images!=null ?
                                    Container(
                                        width: MediaQuery.of(context).size.width - 140,
                                        height: 150,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 20, bottom: 20, top: 10),
                                            itemCount: widget.routes.reviews[index].images.length,
                                            itemBuilder: (BuildContext context, int indexI) {
                                              return Container(
                                                margin: EdgeInsets.only(right: 20),
                                                height: 70,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  const BorderRadius.all(Radius.circular(20)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(widget.routes.reviews[index].images[indexI]),
                                                      fit: BoxFit.fill),
                                                ),
                                              );
                                            })):Container(),
                                        Text(
                                            widget.routes.reviews[index].content,
                                            style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.start,
                                        )
                                  ],
                                )
                              ],
                            ),
                          )));
                },
              ): null)
        ],
      ),
    );
  }
}
