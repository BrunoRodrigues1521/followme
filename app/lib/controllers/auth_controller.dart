import 'package:followme/model/auth_model.dart';
import 'package:followme/services/auth_strategy.dart';

class AuthController{

   static Future GoogleSignIn() async {
     final AuthResponseModel user = await GoogleAuthStrategy.login();
     return user;
   }

   static Future LocalSignIn(email,password) async {
     final AuthResponseModel user = await LocalAuthStrategy.login(email, password);
     return user;
   }

   static Future SignUp(username,email,password) async {
     final AuthResponseModel user = await SignUpStrategy.signUp(username, email, password);
     return user;
   }
 }