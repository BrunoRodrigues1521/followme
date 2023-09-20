import 'package:flutter/material.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/controllers/user_controller.dart';
import 'package:followme/helpers/common/messages.dart';
import 'package:followme/utilities/providers/ProfileScreen/provider.dart';
import 'package:followme/utilities/widgets/profileScreen/info_dashboard_widget.dart';
import 'package:followme/utilities/widgets/profileScreen/settings_dashboard_widget.dart';
import 'package:followme/utilities/widgets/progress_widget.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

Future getAllInfo() async {
  var session = await SessionController.readUserInfo();
  var result = await UserController.getAllInfo(session.email, session.token);
  return result;
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfileScreenProvider(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<ProfileScreenProvider>(
              builder: (context, provider, child) {
            return FutureBuilder(
              future: getAllInfo(),
              initialData: '',
              builder: (
                BuildContext context,
                AsyncSnapshot snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: buildProgressOrange(),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    if (snapshot.data == "expired") {
                      SessionController.deleteSession();
                      Navigator.of(context).pushAndRemoveUntil(
                        // the new route
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen(),
                        ),
                            (Route route) => false,
                      );
                      return Container();
                    } else if (snapshot.data.success != 1) {
                      MessagesHandler.showInSnackBar(
                          snapshot.data!.error, context);
                      return Container();
                    } else {
                      final user = snapshot.data.user;
                      return Column(children: [
                        SizedBox(height: 40),
                        InfoDashboard(user),
                        SizedBox(height: 40),
                        const SettingsDashboard()
                      ]);
                    }
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return MessagesHandler.showInSnackBar(
                      "An error occurred", context);
                }
              },
            );
          }),
        ),
      ),
    );
  }
}
