import 'package:collection/src/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:followme/helpers/submitRouteScreen/helpers.dart';
import 'package:followme/utilities/providers/SubmitRouteScreen/provider.dart';
import 'package:provider/provider.dart';

class TagsList extends StatelessWidget {
  const TagsList(this.tagsController, {Key? key}) : super(key: key);

  final TextEditingController tagsController;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MySubmitRouteFormProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
      height: 25,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: provider.tagsList
            .mapIndexed(
              (index, String text) => Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xffed7c30),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    onPressed: () {
                      provider.removeTagsFromList(index);
                      tagsController.text =
                          SubmitRouteHelpers.convertToString(provider.tagsList);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/close.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          text,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
