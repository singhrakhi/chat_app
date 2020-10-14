import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPrefUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefUserNameKey = "USERNAMEKEY";
  static String sharedPrefUserEmailKey = "USEREMAILKEY";


  // save data to SharedPreferences
  static Future<void> saveUserLoginPref(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPrefUserLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUserPref(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(key, value);
  }
  static Future<void> saveUserEmailPref(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefUserEmailKey, userEmail);
  }

//  get data from sharedPreferences
  static Future<bool> getUserLoginPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPrefUserLoggedInKey);
  }

  static Future<String> getUserPref(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(key);
  }

}