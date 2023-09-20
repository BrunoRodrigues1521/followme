import 'package:flutter/material.dart';
import 'package:followme/model/route_model.dart';
import 'package:followme/providers/api_provider.dart';

class RoutesProvider extends ChangeNotifier{
  bool _isLoading = false;
  List<RouteModel> _lastRoutes = [];
  List<RouteModel> _nearestRoutes = [];

  bool get isLoading => _isLoading;


}