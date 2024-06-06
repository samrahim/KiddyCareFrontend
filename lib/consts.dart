import 'package:flutter/material.dart';

String baseUrl = "http://192.168.1.36:8000";

TextStyle titleTextStyle(double scal, Color color) {
  return TextStyle(
    fontSize: 23 * scal,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle bigTextStyle(double scal, Color color) {
  return TextStyle(
    fontSize: 30 * scal,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle subtitleTextStyle(double scal, Color color) {
  return TextStyle(
    fontSize: 16 * scal,
    fontWeight: FontWeight.w400,
    color: color,
  );
}

TextStyle buttonsTextStyle(double scal, Color color) {
  return TextStyle(
    fontSize: 8 * scal,
    fontWeight: FontWeight.w500,
    color: color,
  );
}
