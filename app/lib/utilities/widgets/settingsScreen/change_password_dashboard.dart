import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/screens/account_info_screen.dart';
import 'package:followme/screens/login_screen.dart';

import '../../../icons.dart';

class ChangePasswordDashboard extends StatelessWidget {
  final nameController = TextEditingController();

  ChangePasswordDashboard({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: 20.0),
              child: const Text("Current Password:",
                  style: TextStyle(
                      fontFamily: 'Pacifico', fontSize: 20)),
            ),
          ),
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
                  hintText: "*********"),
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: 20.0),
              child: const Text("New Password:",
                  style: TextStyle(
                      fontFamily: 'Pacifico', fontSize: 20)),
            ),
          ),
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
                  hintText: "*********"),
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: 20.0),
              child: const Text("Confirm Password:",
                  style: TextStyle(
                      fontFamily: 'Pacifico', fontSize: 20)),
            ),
          ),
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
                  hintText: "*********"),
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: 150,
                    height: 40,
                    margin: const EdgeInsets.only(
                        left: 20, top: 0, right: 10, bottom: 10),
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
                      onPressed: ()  {
                      },
                      child:
                      const Text("Save",
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 14,
                              color: Colors.black)),

                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
