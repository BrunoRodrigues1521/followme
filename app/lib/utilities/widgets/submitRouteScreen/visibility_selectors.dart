import 'package:flutter/material.dart';
import 'package:followme/utilities/providers/SubmitRouteScreen/provider.dart';
import 'package:provider/provider.dart';
class VisiblitySelectors extends StatelessWidget {
  const VisiblitySelectors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MySubmitRouteFormProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 20.0),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: provider.visibility
                        ? Color(0xffED7C30)
                        : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(100)),
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(0xffED7C30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 0),
                  ),
                  onPressed: () {
                    provider.visibility = true;
                  },
                  child: Text(
                    "Public",
                    style: TextStyle(
                        color: provider.visibility
                            ? Colors.white
                            : const Color(0xffED7C30),
                        fontFamily: 'Pacifico'),
                  ))),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: provider.visibility
                    ? Colors.white
                    : const Color(0xffED7C30),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(100)),
                side: const BorderSide(
                  width: 1.0,
                  color: Color(0xffED7C30),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 0),
              ),
              onPressed: () {
                provider.visibility = false;
              },
              child: Text(
                "Private",
                style: TextStyle(
                    color: provider.visibility
                        ? Color(0xffED7C30)
                        : Colors.white,
                    fontFamily: 'Pacifico'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
