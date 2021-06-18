import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//implementing shared preferences
class UserSimplePreferences {
  static SharedPreferences _preferences;
  static const val = "false";
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setval(isOn) async {
    await _preferences.setBool(val, isOn);
  }

  static bool getval() {
    return _preferences.getBool(val);
  }
}
