import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static String seenTutorialPrefs = "seenTutorial";

  static Future<bool> getSeenTutorialPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(seenTutorialPrefs) ?? false;
  }

  static Future<bool> setSeenTutorialPrefs(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(seenTutorialPrefs, value);
  }
}
