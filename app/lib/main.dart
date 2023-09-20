import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:followme/screens/welcome_screen.dart';
import 'consts/colors.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'followMe',
      theme: ThemeData(
        primarySwatch: FollowMeColors.primaryColor,
        fontFamily: 'Pacifico',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 30.0, color: Colors.black),
          headline5: TextStyle(fontSize: 20.0),
          bodyText1: TextStyle(fontSize: 17.0),
          bodyText2: TextStyle(fontSize: 14.0)
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
