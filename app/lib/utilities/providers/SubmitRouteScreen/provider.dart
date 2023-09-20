import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class MySubmitRouteFormProvider with ChangeNotifier{
  int _index = 0;
  bool _visibility = true;
  bool _isLoading = false;
  List<String> _tagsList=[];
  List<XFile>? _imageList = [];

  int get difficultyIndex => _index;
  bool get visibility => _visibility;
  bool get isLoading => _isLoading;
  List<String> get tagsList =>_tagsList;
  List<XFile>? get imageList => _imageList;

  set difficultyIndex(int value) {
    _index = value;
    notifyListeners();
  }
  set visibility(bool value) {
    _visibility = value;
    notifyListeners();
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  set tagsList(List<String> value) {
    _tagsList = value;
    notifyListeners();
  }
  set imageList(List<XFile>? value) {
    _imageList = value;
    notifyListeners();
  }

  void removeTagsFromList(index){
    _tagsList.removeAt(index);
    notifyListeners();
  }

  void removeImagesFromList(index){
    _imageList!.removeAt(index);
    notifyListeners();
  }
}