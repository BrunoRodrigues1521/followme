import 'package:flutter/material.dart';
import 'package:followme/screens/screen_container.dart';
import 'package:followme/screens/login_screen.dart';
import 'package:followme/controllers/session_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();

    SessionController.verifyUserSession().then((value){
      if(value){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=>ScreenContainer())
        );
      }else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=>LoginScreen())
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffED7C30),
      body: Align(
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Container(
                  margin:const EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.0),
                  child: Image.asset("assets/logo/logo.png"),
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ]
          )
      ),
    );
  }
}
