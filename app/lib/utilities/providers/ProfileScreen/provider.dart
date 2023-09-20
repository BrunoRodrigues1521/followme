import 'package:flutter/foundation.dart';

class ProfileScreenProvider with ChangeNotifier{

  bool _infoChanged = false;
  String _imgSrc = "";

  bool get infoChanged => _infoChanged;
  String get imgSrc => _imgSrc;

  set infoChanged(bool value) {
    _infoChanged = value;
    notifyListeners();
  }
  set imgSrc(String value) {
    _imgSrc = value;
    notifyListeners();
  }
}