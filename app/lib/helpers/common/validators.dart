import 'package:image_picker/image_picker.dart';

class Validator{

  static String loginFields(String email,String password) {

    String error;
    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    final passwordPattern = RegExp(r"^[A-Za-z]\w{7,19}$");

    if(email.isEmpty || password.isEmpty){
      error="Empty Fields";
    }else if(!emailPattern.hasMatch(email)){
      error="Insert a valid email adress";
    }
    else if(!passwordPattern.hasMatch(password)){
      error = "Password must be between 7 to 20 characters which contain only characters, numeric digits and underscore and first character must be a letter";
    }
    else{
      error="";
    }
    return error;
  }

  static String submitRouteFields(String name,String description,List<String> tagsList,List<XFile>? imagesList){
    String error;

    if(name.isEmpty || description.isEmpty || tagsList.isEmpty || imagesList==null || imagesList.isEmpty){
      error ="Empty Fields";
    }else{
      error="";
    }
    return error;
  }

  static String submitReviewFields(String review){
    String error;

    if(review.isEmpty){
      error ="Empty Fields";
    }else{
      error="";
    }
    return error;
  }
}