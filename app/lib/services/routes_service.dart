import 'package:followme/helpers/common/helpers.dart';
import 'package:followme/providers/api_provider.dart';
import 'package:image_picker/image_picker.dart';

class RoutesService {

  static Future create(String name,String description, bool visibility, int difficulty,List<String> tagsList,List<XFile>? imagesList,String email,String token, List<dynamic> points) async {
    try {
      List<String> encodedImages=[];
      for (var img in imagesList!) {
        final base64Image = await CommonHelpers.base64Encoder(img);
        encodedImages.add(base64Image);
      }
      var result = await APIProvider.createRoute(name,description,visibility,difficulty,tagsList,encodedImages,email,token, points);
      return result;
    } catch (err) {
      print(err);
    }
  }
  static Future getRoutes(String email, String token) async {
    try{
      return await APIProvider.getRoutes(email, token);
    }catch(err){
      print(err);
    }
  }

  static Future getRouteById(String name, String token) async {
    try{
      return await APIProvider.getRouteById(name, token);
    }catch(err){
      print(err);
    }
  }

  static Future insertReviews(String comment, List<XFile>? imageList,String routeId, String email,String token) async{
    try {
      List<String> encodedImages=[];
      for (var img in imageList!) {
        final base64Image = await CommonHelpers.base64Encoder(img);
        encodedImages.add(base64Image);
      }
      var result = await APIProvider.insertReviews(comment,encodedImages,routeId,email,token);
      return result;
    } catch (err) {
      print(err);
    }

  }
}