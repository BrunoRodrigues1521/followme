import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/screens/acess_screen.dart';
import 'package:followme/screens/account_info_screen.dart';
import 'package:followme/screens/login_screen.dart';

import '../../../icons.dart';

class SettingsDashboard extends StatelessWidget {
  const SettingsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Material(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountInfoScreen()),
                    );
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
                        Icon(
                          MyFlutterApp.profile_icon_outlined,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Account Info",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Material(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AcessScreen()),
                    );
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
                        Icon(
                          Icons.security,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Acess and Security",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Material(
              child: InkWell(
                  onTap: () {
                    SessionController.deleteSession();
                    Navigator.of(context).pushAndRemoveUntil(
                      // the new route
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                      (Route route) => false,
                    );
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
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Log Out",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
