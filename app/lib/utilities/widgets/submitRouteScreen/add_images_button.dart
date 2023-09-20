import 'package:flutter/material.dart';
import 'package:followme/helpers/common/helpers.dart';
import 'package:followme/utilities/providers/SubmitRouteScreen/provider.dart';
import 'package:provider/provider.dart';

class AddImagesButton extends StatelessWidget {
  const AddImagesButton(this.imgPicker,{Key? key}) : super(key: key);
  final imgPicker;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MySubmitRouteFormProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 20.0),
      height: 120.0,
      child: Row(
        children: <Widget>[
          Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffED7C30),
                  width: 2.0,
                ),
                borderRadius:
                BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      final selectedImagesList =
                      await CommonHelpers
                          .selectImages(
                          imgPicker);
                      if (selectedImagesList !=
                          null) {
                        provider.imageList = provider.imageList! + selectedImagesList;
                      }
                    },
                    child: Image.asset(
                        "assets/icons/add.png",
                        width: 80,
                        height: 80),
                  ),
                  const Text("add Images",
                      style: TextStyle(
                          color: Color(0xffED7C30),
                          fontFamily: 'Pacifico',
                          fontSize: 17)),
                ],
              )),
        ],
      ),
    );
  }
}
