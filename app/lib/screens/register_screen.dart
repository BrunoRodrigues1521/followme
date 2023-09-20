import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:followme/controllers/auth_controller.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/helpers/common/messages.dart';
import 'package:followme/helpers/common/validators.dart';
import 'package:followme/screens/screen_container.dart';
import 'package:followme/utilities/widgets/progress_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffED7C30),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 0.0),
                        child: Image.asset(
                          "assets/logo/logo.png",
                          width: 250,
                          height: 250,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 40.0),
                          child: const Text("Username:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pacifico',
                                  fontSize: 20)),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(14),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Insert your username"),
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 40.0),
                          child: const Text("Email:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pacifico',
                                  fontSize: 20)),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(14),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Insert your email"),
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 40.0),
                          child: const Text("Password:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pacifico',
                                  fontSize: 20)),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(14),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Insert your password"),
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          )),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                width: 150,
                                height: 40,
                                margin: const EdgeInsets.only(
                                    left: 40, top: 10, right: 10, bottom: 10),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(100))),
                                    onPressed: () async {
                                      var valErrors = Validator.loginFields(emailController.text, passwordController.text);
                                      if(valErrors.isNotEmpty){
                                        MessagesHandler.showInSnackBar(valErrors,context);
                                        return;
                                      }
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        var result = await AuthController
                                            .SignUp(usernameController.text,emailController.text, passwordController.text);
                                        setState(() {
                                          isLoading = false;
                                        });
                                        if (result.success !=1) {
                                          MessagesHandler.showInSnackBar(result.error,context);
                                        } else {
                                          SessionController.saveUserInfo(result.token);
                                          Navigator.pushReplacement(context, MaterialPageRoute(
                                              builder: (context) =>
                                              const ScreenContainer()));
                                        }
                                      }catch(err){
                                        setState(() {
                                          isLoading = false;
                                        });
                                        MessagesHandler.showInSnackBar("An error has occurred",context);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        const Text("Register",
                                            style: TextStyle(
                                                fontFamily: 'Pacifico',
                                                fontSize: 14,
                                                color: Colors.black)),
                                        Image.asset(
                                            "assets/images/arrow-right.png",
                                            width: 20),
                                      ],
                                    ))),
                          ),
                          isLoading ? buildProgress() : Container(),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Already have an account? Login here",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
                                    }),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
