import 'package:flutter/material.dart';

class MessagesHandler{
  static showInSnackBar(String value,context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value, textAlign: TextAlign.center),
        backgroundColor: Colors.black));
  }
}