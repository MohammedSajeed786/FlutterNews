import 'package:flutter/material.dart';
import 'package:news/prefer.dart';
import 'package:provider/provider.dart';

//Provider
class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  //returns true if theme is dark
  bool get isDarkmode {
    bool val = UserSimplePreferences.getval();
    themeMode = val == null
        ? ThemeMode.dark
        : val == true
            ? ThemeMode.dark
            : ThemeMode.light;
    return themeMode == ThemeMode.dark;
  }

//thememode=dark if isOn is true;
  void toggle(isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await UserSimplePreferences.setval((isOn));
  }
}

class Mytheme {
  static final dark = ThemeData(
      //scaffold bg color
      scaffoldBackgroundColor: Colors.grey.shade900,
      //text bg col
      colorScheme: ColorScheme.dark(),
      primaryColor: Colors.black);
  static final light = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      primaryColor: Colors.white);
}
