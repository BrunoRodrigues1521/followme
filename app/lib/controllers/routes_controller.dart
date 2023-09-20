import 'package:followme/controllers/session_controller.dart';
import 'package:followme/model/route_model.dart';
import 'package:followme/model/session_model.dart';
import 'package:followme/services/routes_service.dart';
import 'package:image_picker/image_picker.dart';

class RoutesController{

  static Future create(String name,String description, bool visibility, int difficulty,List<String> tagsList,List<XFile>? imagesList,String email,String token, List<dynamic> points) async {

    try {
      final response = await RoutesService.create(name,description,visibility,difficulty+1,tagsList,imagesList,email,token, points);
      return response;
    } catch (err) {
      print(err);
    }
  }

  static Future getRoutes(String email, String token) async{
    try{
      return await RoutesService.getRoutes(email, token);
    }catch(err){
      print(err);
    }
  }

  static Future getRouteById(String name) async {
    SessionModel session = await SessionController.readUserInfo();
    var result = await RoutesService.getRouteById(name, session.token);
    return result;
  }

  static Future addReview(String comment, List<XFile>? imageList,String routeId,String email,String token) async {
    var result = await RoutesService.insertReviews(comment,imageList,routeId,email,token);
    return result;
  }

}