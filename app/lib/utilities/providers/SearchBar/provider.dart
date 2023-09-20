import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/model/route_model.dart';
import 'package:followme/model/session_model.dart';
import 'package:followme/providers/api_provider.dart';
import 'package:followme/screens/login_screen.dart';

class SearchBarProvider with ChangeNotifier{
  int _difficultyIndex = 0;
  int _distanceIndex = 0;
  int _ratingIndex = 0;
  bool _isLoading = false;
  bool _routesLoaded = false;
  List<RouteModel> _routes = [];

  List<RouteModel> get routes => _routes;

  bool get routesLoaded => _routesLoaded;

  set routesLoaded(bool value) {
    _routesLoaded = value;
    notifyListeners();
  }

  int get difficultyIndex => _difficultyIndex;

  bool get isLoading => _isLoading;

  int get distanceIndex => _distanceIndex;

  int get ratingIndex => _ratingIndex;

  set difficultyIndex(int value) {
    _difficultyIndex = value;
    notifyListeners();
  }

  set distanceIndex(int value){
    _distanceIndex = value;
    notifyListeners();
  }

  set ratingIndex(int value){
    _ratingIndex = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getRoutes(BuildContext context, {required String city}) {
    _isLoading = true;
    notifyListeners();
    _filterRoutes(context, city: city).then((value) {
      _routes = value;
      _isLoading = false;
      _routesLoaded = true;
      notifyListeners();
    });
  }

  Future<List<RouteModel>> _filterRoutes(BuildContext context,
      {required String city}) async {
    SessionModel session = await SessionController.readUserInfo();
    var result = await APIProvider.filterRoutes(
        city,
        (difficultyIndex + 1).toString(),
        _getDistance(),
        ratingIndex.toString(),
        session.token);
    if (result == "expired") {
      SessionController.deleteSession();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    return result;
  }

  String _getDistance(){
    switch(distanceIndex){
      case 0: return "100";
      case 1: return "50";
      case 2: return "25";
      default: return "300";
    }
  }
}