import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class MapScreenProvider with ChangeNotifier{
  List<XFile>? _imageList = [];

  List<XFile>? get imageList => _imageList;

  set imageList(List<XFile>? value) {
    _imageList = value;
    notifyListeners();
  }

  void removeImagesFromList(index){
    _imageList!.removeAt(index);
    notifyListeners();
  }
}