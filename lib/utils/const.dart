import 'package:flutter/material.dart';

class Const {
  //routes
  static const String rootRoute = "/root";
  static const String mainRoute = "/main";
  static const String welcomeRoute = "/welcome";
  static const String signInRoute = "/signin";
  static const String signUpRoute = "/signup";

  //strings
  static const String appName = "Bóng Đá Phủi";
  static const String start = "Bắt Đầu";
  static const String signIn = "Đăng Nhập";
  static const String signUp = "Đăng Ký";
  static const String countField = "Số lượng sân";
  static const String priceAVG = "Giá trung bình";
  static const String notUpdate = "Chưa cập nhật";
  static const String threeDot = "...";
  static const String selectPhone = "Chọn số để gọi";
  static const String cancel = "Huỷ";
  static const String call = "Gọi";

  //colors
  static List<Color> kitGradients = [
    Colors.blueGrey.shade800,
    Colors.black87,
  ];

  //fonts
  static const String openSansFont = "OpenSans";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

  //json
  static const String jsonCity = "assets/json/json_city.json";

  //images
  static const String imageDir = "assets/images";
  static const String icLauncher = "$imageDir/ic_launcher.png";
  static const String icSplash = "$imageDir/ic_splash.png";
  static const String icPlaying = "$imageDir/playing.png";

  //Size
  static const double size_5 = 5.0;
  static const double size_8 = 8.0;
  static const double size_10 = 10.0;
  static const double size_15 = 15.0;
  static const double size_20 = 20.0;
  static const double size_30 = 30.0;
  static const double size_35 = 35.0;
  static const double size_40 = 40.0;
  static const double size_50 = 50.0;
  static const double size_60 = 60.0;
  static const double size_100 = 100.0;

  //SharedPreferences
  static const String seenTutorialPrefs = "seenTutorial";

  //FireBase Collection
  static const String tutorialCollection = "tutorial";
  static const String fieldsCollection = "fields";
}
