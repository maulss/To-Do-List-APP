import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static void seenOrBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seenOrboarding', true);
  }
}
