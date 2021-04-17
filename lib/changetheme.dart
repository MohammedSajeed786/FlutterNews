import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

class ChangeTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        value: themeprovider.isDarkmode,
        onChanged: (val) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggle(val);
        });
  }
}

class Changetheme extends StatefulWidget {
  @override
  _ChangethemeState createState() => _ChangethemeState();
}

class _ChangethemeState extends State<Changetheme> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: themeProvider.themeMode == ThemeMode.dark
          ? Icon(Icons.wb_sunny,color:Colors.yellow)
          : Icon(Icons.brightness_3,color:Colors.blue),
      onPressed: () {
        bool val = themeProvider.themeMode == ThemeMode.dark ? false : true;
        final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggle(val);
      },
    );
  }
}










