import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CommonHelpers{

  static Future<XFile?> selectImage(imgPicker) async {
    final XFile? selectedImage = await imgPicker.pickImage(source: ImageSource.gallery);
    if (selectedImage!=null) {
      return selectedImage;
    }
    return null;
  }

  static Future<List<XFile>?> selectImages(imgPicker) async {
    List<XFile>? selectedImages = await imgPicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      return selectedImages;
    }
    return null;
  }

  static Future<String> base64Encoder(XFile img) async{
    final bytes = await File(img.path).readAsBytesSync();
    String encodedImage = base64Encode(bytes);
    return encodedImage;
  }

  static String convertDifficulty(int difficulty){
    String conv_difficulty="";
    switch(difficulty) {
      case 1: {
        conv_difficulty = "Low";
      }
      break;

      case 2: {
        conv_difficulty = "Medium";
      }
      break;

      case 3:{
        conv_difficulty = "Hard";
      }
      break;
    }
    return conv_difficulty;
  }
}