
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:followme/helpers/common/messages.dart';
import 'package:followme/model/session_model.dart';
import 'package:followme/screens/login_screen.dart';
import 'package:latlong2/latlong.dart';

import 'package:followme/helpers/common/validators.dart';
import 'package:followme/controllers/routes_controller.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/helpers/submitRouteScreen/helpers.dart';
import 'package:followme/utilities/providers/SubmitRouteScreen/provider.dart';
import 'package:followme/utilities/widgets/progress_widget.dart';
import 'package:followme/utilities/widgets/submitRouteScreen/add_images_button.dart';
import 'package:followme/utilities/widgets/submitRouteScreen/difficulty_toggle_switch.dart';
import 'package:followme/utilities/widgets/submitRouteScreen/images_list_view.dart';
import 'package:followme/utilities/widgets/submitRouteScreen/tags_list.dart';
import 'package:followme/utilities/widgets/submitRouteScreen/visibility_selectors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SubmitRouteScreen extends StatefulWidget {
  const SubmitRouteScreen( {Key? key}) : super(key: key);


  @override
  _SubmitRouteScreenState createState() => _SubmitRouteScreenState();
}


class _SubmitRouteScreenState extends State<SubmitRouteScreen> {
  final ImagePicker imgPicker = ImagePicker();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final pointList = ModalRoute.of(context)!.settings.arguments as List<LatLng>;
    print(pointList.length);
    var waypoints = [];
    for (var i = 0; i < pointList.length; i++)
    {
      waypoints.add({"lat": pointList[i].latitude, "lon": pointList[i].longitude});
    }

    print(waypoints);
    return ChangeNotifierProvider(
        create: (BuildContext context) => MySubmitRouteFormProvider(),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Consumer<MySubmitRouteFormProvider>(
                    builder: (context, provider, child) {
                  return Form(
                    child: Column(
                      children: [
                        ////image
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {}, // handle your image tap here
                                child: Image.asset(
                                    "assets/icons/arrow_alt_left.png",
                                    width: 40,
                                    height: 40),
                              ),
                              Text("New Route",
                                  style: TextStyle(
                                      fontFamily: 'Pacifico', fontSize: 30)),
                            ],
                          ),
                        ),
                        provider.imageList!.isEmpty
                            ? AddImagesButton(imgPicker)
                            : ImagesListView(imgPicker),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20.0),
                            child: const Text("Name:",
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 20)),
                          ),
                        ),
                        //////name field
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: const BorderSide(
                                        color: Color(0xffED7C30))),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(14),
                                hintText: "Insert route name"),
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            child: const Text("Description:",
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 20)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: TextFormField(
                            minLines:
                                6, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: descriptionController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Color(0xffED7C30))),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(14),
                                hintText: "Insert your description"),
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            child: const Text("Difficulty:",
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 20)),
                          ),
                        ),
                        const DifficultyToggleSwitch(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            child: const Text("Visibility:",
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 20)),
                          ),
                        ),
                        VisiblitySelectors(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            child: const Text("Tags:",
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 20)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: TextFormField(
                            controller: tagsController,
                            keyboardType: TextInputType.text,
                            onChanged: (text){
                              provider.tagsList = SubmitRouteHelpers().getTags(text);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: const BorderSide(
                                        color: Color(0xffed7c30))),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(14),
                                hintText: "Insert some tags"),
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ),
                        provider.tagsList.isNotEmpty
                            ? TagsList(tagsController)
                            : Container(),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  width: 150,
                                  height: 40,
                                  margin: const EdgeInsets.only(
                                      left: 20, top: 10, right: 10, bottom: 10),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        side: const BorderSide(
                                          width: 1.0,
                                          color: Color(0xffED7C30),
                                        ),
                                      ),
                                      onPressed: () async {
                                        var valErrors =
                                            Validator.submitRouteFields(
                                                nameController.text,
                                                descriptionController.text,
                                                provider.tagsList,
                                                provider.imageList);
                                        if (valErrors.isNotEmpty) {
                                          MessagesHandler.showInSnackBar(valErrors,context);
                                          return;
                                        }
                                        try {
                                          provider.isLoading = true;
                                          SessionModel session = await SessionController.readUserInfo();
                                          final result =
                                              await RoutesController.create(
                                                  nameController.text,
                                                  descriptionController.text,
                                                  provider.visibility,
                                                  provider.difficultyIndex,
                                                  provider.tagsList,
                                                  provider.imageList,
                                                  session.email,
                                                  session.token,
                                                  waypoints,
                                              );
                                          provider.isLoading = false;
                                          if (result == "expired") {
                                            SessionController.deleteSession();
                                            Navigator.of(context).pushAndRemoveUntil(
                                              // the new route
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => LoginScreen(),
                                              ),
                                                  (Route route) => false,
                                            );
                                          } else if (result.success!=1) {
                                            MessagesHandler.showInSnackBar(result.error,context);
                                          } else {
                                            MessagesHandler.showInSnackBar("Success",context);
                                          }
                                        } catch (err) {
                                          MessagesHandler.showInSnackBar(
                                              "An error has occurred",context);
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const Text("Continue",
                                              style: TextStyle(
                                                  fontFamily: 'Pacifico',
                                                  fontSize: 14,
                                              color: Colors.black)),
                                          Image.asset(
                                              "assets/images/arrow-right.png",
                                              width: 20),
                                        ],
                                      ))),
                            ),
                            provider.isLoading ? buildProgressOrange() : Container(),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            )));
  }

}

