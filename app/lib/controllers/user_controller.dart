import 'package:followme/services/user_services.dart';
import 'package:image_picker/image_picker.dart';

class UserController{
  static Future getAllInfo(String email,String token) async {
    final response = await UserService.getAllInfo(email, token);
    return response;
  }

  static Future updateUserPicture(XFile image,String email,String token,) async {
    final response = await UserService.updateUserPicture(image,email,token);
    return response;
  }

  static Future addFavourites(String email,String favourite,String token) async {
    final response = await UserService.addFavourites(email,favourite,token);
    return response;
  }
}