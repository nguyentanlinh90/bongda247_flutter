import 'package:flutter/material.dart';

class Const {
  //routes
  static const String rootRoute = "/root";
  static const String welcomeRoute = "/welcome";
  static const String signInRoute = "/signin";
  static const String signUpRoute = "/signup";

  //strings
  static const String appName = "Bóng Đá Phủi";
  static const String signIn = "Đăng Nhập";
  static const String signUp = "Đăng Ký";

  //colors
  static List<Color> kitGradients = [
    Colors.blueGrey.shade800,
    Colors.black87,
  ];

  //fonts
  static const String openSans = "OpenSans";

  //Size
  static const double size_15 = 15.0;
  static const double size_20 = 20.0;
  static const double size_30 = 30.0;
  static const double size_40 = 40.0;

  //SharedPreferences
  static const String seenTutorialPrefs = "seenTutorial";

  //FireBase Collection
  static const String tutorialCollection = "tutorial";
  static const String fieldsCollection = "fields";
}
