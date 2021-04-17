import 'package:flutter/material.dart';
import 'package:news/prefer.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkmode{
     bool val = UserSimplePreferences.getval();
    themeMode = val == null
        ? ThemeMode.dark
        : val == true
            ? ThemeMode.dark
            : ThemeMode.light;
    return themeMode == ThemeMode.dark;
  }
  void toggle(isOn) async{
     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await UserSimplePreferences.setval((isOn));
  }
}

class Mytheme {
  static final dark = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(),
      primaryColor: Colors.black);
  static final light = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      primaryColor: Colors.white);
}
