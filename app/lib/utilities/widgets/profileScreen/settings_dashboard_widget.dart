import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/screens/login_screen.dart';
import 'package:followme/screens/settings_sceen.dart';

class SettingsDashboard extends StatelessWidget {
  const SettingsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: FollowMeColors.darkAccentColor.shade200
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/settings_fill.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Settings",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
