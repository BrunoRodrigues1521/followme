import 'dart:io';
import 'package:flutter/material.dart';
import 'package:followme/helpers/common/helpers.dart';
import 'package:followme/utilities/providers/SubmitRouteScreen/provider.dart';
import 'package:provider/provider.dart';

class ImagesListView extends StatelessWidget {
  const ImagesListView(this.imgPicker, {Key? key}) : super(key: key);
  final imgPicker;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MySubmitRouteFormProvider>(context);
    return Column(children: [
      Container(
          margin: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 0),
          decoration: BoxDecoration(
            color: const Color(0xffED7C30)
                .withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20, top: 20, right: 10),
            child: Row(children: [
              Text(
                "Selected images",
                style: TextStyle(
                    color: Color(0xffED7C30),
                    fontFamily: 'Pacifico',
                    fontSize: 15),
              ),
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
                child: Image.asset(
                    "assets/icons/add.png",
                    width: 30,
                    height: 30),
              )
            ]),
          )),
      Container(
        margin: const EdgeInsets.only(
            left: 20, right: 20, bottom: 20),
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xffED7C30)
              .withOpacity(0.2),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => Padding(
              padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
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
                              width: 25,
                              height: 25,
                            )),
                      ),
                    ],
                  ))),
          itemCount: provider.imageList!.length,
        ),
      ),
    ]);
  }
}
