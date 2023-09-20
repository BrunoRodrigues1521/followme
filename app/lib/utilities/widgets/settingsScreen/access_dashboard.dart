import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/screens/account_info_screen.dart';
import 'package:followme/screens/change_password_screen.dart';
import 'package:followme/screens/login_history_screen.dart';
import 'package:followme/screens/login_screen.dart';
import 'package:followme/utilities/widgets/settingsScreen/change_password_dashboard.dart';

import '../../../icons.dart';

class AccessDashboard extends StatelessWidget {
  const AccessDashboard({Key? key}) : super(key: key);

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
                      MaterialPageRoute(builder: (context) => const LoginHistoryScreen()),
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
                          Icons.history,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Login History",
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
                      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
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
                          Icons.vpn_key,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Change my password",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          ),

        ],
      ),
    );
  }
}
