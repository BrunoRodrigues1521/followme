import 'package:flutter/material.dart';
class FollowMeColors{
  FollowMeColors._();

  static const int _primaryColorPrimaryValue = 0xFFED7C30;
  static const MaterialColor primaryColor = MaterialColor(_primaryColorPrimaryValue, <int, Color>{
    50: Color(0xFFFDEFE6),
    100: Color(0xFFFAD8C1),
    200: Color(0xFFF6BE98),
    300: Color(0xFFF2A36E),
    400: Color(0xFFF0904F),
    500: Color(_primaryColorPrimaryValue),
    600: Color(0xFFEB742B),
    700: Color(0xFFE86924),
    800: Color(0xFFE55F1E),
    900: Color(0xFFE04C13),
  });

  static const int _lightAccentColorPrimaryValue = 0xFFEFF6EE;
  static const MaterialColor lightAccentColor = MaterialColor(_lightAccentColorPrimaryValue, <int, Color>{
    50: Color(0xFFFDFEFD),
    100: Color(0xFFFAFCFA),
    200: Color(0xFFF7FBF7),
    300: Color(0xFFF4F9F3),
    400: Color(0xFFF1F7F1),
    500: Color(_lightAccentColorPrimaryValue),
    600: Color(0xFFEDF5EC),
    700: Color(0xFFEBF3E9),
    800: Color(0xFFE8F2E7),
    900: Color(0xFFE4EFE2),
  });

  static const int _darkAccentColorPrimaryValue = 0xFF545E56;
  static const MaterialColor darkAccentColor = MaterialColor(_darkAccentColorPrimaryValue, <int, Color>{
    50: Color(0xFFEAECEB),
    100: Color(0xFFCCCFCC),
    200: Color(0xFFAAAFAB),
    300: Color(0xFF878E89),
    400: Color(0xFF6E766F),
    500: Color(_darkAccentColorPrimaryValue),
    600: Color(0xFF4D564F),
    700: Color(0xFF434C45),
    800: Color(0xFF3A423C),
    900: Color(0xFF29312B),
  });
}

