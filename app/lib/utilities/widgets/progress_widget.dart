import 'package:flutter/material.dart';

Widget buildProgress() {
  return const SizedBox(
    width: 20,
    height: 20,
    child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white)
    ),
  );
}

Widget buildProgressOrange() {
  return const SizedBox(
    width: 20,
    height: 20,
    child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.orange)
    ),
  );
}