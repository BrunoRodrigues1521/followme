
import 'package:followme/helpers/common/helpers.dart';
import 'package:followme/providers/api_provider.dart';
import 'package:image_picker/image_picker.dart';

class UserService {

  static Future getAllInfo(String email,String token) async {
    try {
      var result = await APIProvider.getUserInfo(email, token);
      return result;
    } catch (err) {
      print(err);
    }
  }

  static Future updateUserPicture(XFile image,String email, String token) async{
    try {
      final encodedImage = await CommonHelpers.base64Encoder(image);
      var result = await APIProvider.updateUserPicture(encodedImage,email,token);
      return result;
    } catch (err) {
      print(err);
    }
  }

  static Future addFavourites(String email, String favourite,String token) async{
    try {
      var result = await APIProvider.insertFavourites(email, favourite,token);
      return result;
    } catch (err) {
      print(err);
    }
  }
}