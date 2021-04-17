import 'package:flutter/material.dart';
import 'package:news/prefer.dart';
import 'package:news/theme.dart';
import 'package:provider/provider.dart';
import 'views/home.dart';
import 'theme.dart' as tm;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return tm.ThemeProvider();
    }, builder: (context, child) {
      final themeProvider = Provider.of<tm.ThemeProvider>(context);
     bool val= themeProvider.isDarkmode;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: themeProvider.themeMode,
        theme: tm.Mytheme.light,
        darkTheme: tm.Mytheme.dark,
        home: Home(),
      );
    });
  }
}
