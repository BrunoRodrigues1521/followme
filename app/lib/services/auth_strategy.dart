import 'package:firebase_auth/firebase_auth.dart';
import 'package:followme/providers/api_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthStrategy{
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  static Future login() async {
      final gUser = await _googleSignIn.signIn();
      if(gUser==null) return;
      final googleAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var result = await APIProvider.validateGtoken(credential.idToken);
      if(result.success!=1){
        await _googleSignIn.signOut();
        return result;
      }
      await FirebaseAuth.instance.signInWithCredential(credential);
      return result;
  }
}

class LocalAuthStrategy{

    static Future login(email,password) async {
      var result = await APIProvider.login(email,password);
      return result;

    }
}

class SignUpStrategy{
  static Future signUp(username,email,password) async {
    var result = await APIProvider.signUpUser(username,email,password);
    return result;
  }
}