import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static String seenTutorialPrefs = "seenTutorial";
//  static String uidFireBaseUser = "uidFireBaseUser";

  static Future<bool> getSeenTutorialPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(seenTutorialPrefs) ?? false;
  }

  static setSeenTutorialPrefs(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(seenTutorialPrefs, value);
  }

//  static Future<String> getUidFireBaseUser() async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.getString(uidFireBaseUser) ?? '';
//  }

//  static setUidFireBaseUser(String value) async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString(uidFireBaseUser, value);
//  }
}
