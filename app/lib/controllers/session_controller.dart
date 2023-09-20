import 'package:followme/model/session_model.dart';
import 'package:followme/services/secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SessionController {
  static Future <bool> verifyUserSession() async {
    try {
      final SecureStorage secureStorage = SecureStorage();
      var token = await secureStorage.readSecureData("user");
      if (token != null) {
        return true;
      }
      return false;
    }catch(err){
      return false;
    }
  }

  static Future<bool> saveUserInfo(result) async {
    try {
      final SecureStorage secureStorage = SecureStorage();
      await secureStorage.writeSecureData("user", result);
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future readUserInfo() async {
    try {
      final SecureStorage secureStorage = SecureStorage();
      var token = await secureStorage.readSecureData("user");
      if (token != null) {
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        payload['token'] = token;
        var session = SessionModel.fromJson(payload);
        return session;
      }
      return null;
    } catch (err) {
      return null;
    }
  }

  static Future deleteSession() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final SecureStorage secureStorage = SecureStorage();

      await secureStorage.deleteSecureData("user");
      await _googleSignIn.signOut();
    } catch (err) {
      return null;
    }
  }
}