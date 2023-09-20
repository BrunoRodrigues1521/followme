import 'dart:convert';

import 'package:followme/model/auth_model.dart';
import 'package:followme/model/route_model.dart';
import 'package:followme/model/submit_route_model.dart';
import 'package:followme/model/user_info_model.dart';
import 'package:http/http.dart' as http;

class APIProvider {
  static Future<AuthResponseModel> login(email, password) async {
    var url =
        Uri.parse("https://followme-dev-les-2021.herokuapp.com/auth/login");
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    return AuthResponseModel.fromJson(json.decode(response.body));
  }

  static Future<AuthResponseModel> validateGtoken(token) async {
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/auth/google");
    final response = await http.post(url, body: {
      "token": token
    });
    return AuthResponseModel.fromJson(json.decode(response.body));
  }

  static Future<AuthResponseModel> signUpUser(username,email, password) async {
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/auth/register");
    final response = await http.post(url, body: {
      "username" : username,
      "email": email,
      "password": password,
    });
    return AuthResponseModel.fromJson(json.decode(response.body));
  }

  static Future getUserInfo(String email,String token) async{
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/user/$email");
    final response = await http.get(url,headers: {"Authorization":"Bearer $token","Content-Type":"application/json"});
    if(response.statusCode==401){
      return "expired";
    }
    print(json.decode(response.body));
    return UserInfoModel.fromJson(json.decode(response.body));
  }

  static Future updateUserPicture(String image,String email, String token) async{
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/user/$email");
    final response = await http.patch(url,headers: {"Authorization":"Bearer $token","Content-Type":"application/json"},body:jsonEncode(
        {
          "picture": image
        }
    ));
    if(response.statusCode==401){
      return "expired";
    }
    return UserInfoModel.fromJson(json.decode(response.body));

  }

  static Future createRoute(String name,String description, bool visibility, int difficulty,List<String> tagsList,List<String> imagesList,String email,String token, List<dynamic> points) async{
    var url = Uri.parse("https://followme-dev-les-2021.herokuapp.com/routes");

      final response = await http.post(url,headers: {"Authorization":"Bearer $token","Content-Type":"application/json"}, body: jsonEncode({
        "name": name,
        "description":description,
        "visibility":visibility,
        "difficulty":difficulty,
        "tags":tagsList,
        "images":imagesList,
        "distance":70,//hardcoded for testing
        "waypoints":points,
        "email":email
      }));

      if(response.statusCode==401){
        return "expired";
      }
    return SubmitRouteModel.fromJson(json.decode(response.body));

  }

   static Future getRoutes(String email, String token) async{
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/routes/$email?page=1");
    final response = await http.get(url, headers: {"Authorization":"Bearer $token","Content-Type":"application/json"});
    if(response.statusCode==401){
      return "expired";
    }
    print(json.decode(response.body));
    Map<String, dynamic> parsedJson = json.decode(response.body);
    List<RouteModel> routes = parsedJson['routes'].map<RouteModel>((routeJson) => RouteModel.fromJson(routeJson)).toList();
    return routes;
  }

  static Future getNearestRoutes(String city, double lat, double long, String token) async{
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/routes/filter?page=1&lat=$lat&lon=$long");
    final response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    });
    if (response.statusCode == 401) {
      return "expired";
    }
    Map<String, dynamic> parsedJson = json.decode(response.body);
    List<RouteModel> routes = parsedJson['routes']
        .map<RouteModel>((routeJson) => RouteModel.fromJson(routeJson))
        .toList();
    return routes;
  }

  static Future insertFavourites(String email, String favourite,String token) async{
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/user/favourites");
    final response = await http.post(url,headers: {"Authorization":"Bearer $token","Content-Type":"application/json"},body:jsonEncode(
        {
          "email": email,
          "favourites": [favourite]
        }
    ));
    if(response.statusCode==401){
      return "expired";
    }
  }

  static Future getRouteById(String name, String token) async{
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/routes/filter?page=1&name=$name");
    final response = await http.get(url, headers: {"Authorization":"Bearer $token","Content-Type":"application/json"});
    if(response.statusCode==401){
      return "expired";
    }
    Map<String, dynamic> parsedJson = json.decode(response.body);
    List<RouteModel> routes = parsedJson['routes'].map<RouteModel>((routeJson) => RouteModel.fromJson(routeJson[0])).toList();
    return routes;
  }

  static Future insertReviews(String comment, List<String> encodedImages,String routeId ,String email,String token) async{

    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/routes/review");
    final response = await http.put(url,headers: {"Authorization":"Bearer $token","Content-Type":"application/json"},body: jsonEncode({
      "id":routeId,
      "review":{
        "content":comment,
        "images":encodedImages,
        "email":email
      }
    }));
    if(response.statusCode==401){
      return "expired";
    }
    Map<String, dynamic> parsedJson = json.decode(response.body);
    List<RouteModel> routes = parsedJson['routes'].map<RouteModel>((routeJson) => RouteModel.fromJson(routeJson)).toList();
    return routes;

  }

  static Future addRatings(routeId, double rating,String token) async {
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/routes/rating");
    final response = await http.put(url,headers: {"Authorization":"Bearer $token","Content-Type":"application/json"},body: jsonEncode({
      "id":routeId,
      "rating":rating
    }));
    print(json.decode(response.body));
    if(response.statusCode==401){
      return "expired";
    }
    Map<String, dynamic> parsedJson = json.decode(response.body);
    List<RouteModel> routes = parsedJson['routes'].map<RouteModel>((routeJson) => RouteModel.fromJson(routeJson)).toList();
    return routes;
  }

  static Future filterRoutes(String city, String difficulty, String distance, String rating, String token) async{
    var url = Uri.parse(
        "https://followme-dev-les-2021.herokuapp.com/routes/filter?page=1&difficulty=$difficulty&distance=$distance&rating=$rating");

    final response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    });
    if (response.statusCode == 401) {
      return "expired";
    }
    Map<String, dynamic> parsedJson = json.decode(response.body);
    List<RouteModel> routes = parsedJson['routes'][0]
        .map<RouteModel>((routeJson) => RouteModel.fromJson(routeJson))
        .toList();
    return routes;
  }
}