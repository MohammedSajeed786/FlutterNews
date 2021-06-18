import 'package:flutter/material.dart';
import 'package:news/prefer.dart';
import 'package:news/theme.dart';
import 'package:provider/provider.dart';
import 'views/home.dart';
import 'theme.dart' as tm;

//flow:-
//main
//myapp->home
//HOME:-
//    Appbar
//    Theming:-
//             #CHANGETHEME(creates switch)
//             #Theme(provider for theme management)
//             #PREFER(shared preference)
//    Body:-
//
//    1)categories list:-
//         #CATEGORY A MODEL:- define a category class
//         #DATA:-return list of categories where each category is a object of categoryn model
//    2)headlines:-
//        #ARTICLE MODEL:- modelling a article
//        #NEWS:-
//        list of article objects of type article model of headlines
//        list of articles related to categories
// CATEGORY_NEWS:-
//        when we click a category we get articles, it decides the view of that page
// ARTICLE VIEW :-
//       decides how a article will look
//
//
//
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  runApp(MyApp());
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return tm.ThemeProvider();
    }, builder: (context, child) {
      final themeProvider = Provider.of<tm.ThemeProvider>(context);
      bool val = themeProvider.isDarkmode;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News',
        themeMode: themeProvider.themeMode,
        //if we select light
        theme: tm.Mytheme.light,
        //if we select dark`
        darkTheme: tm.Mytheme.dark,
        home: Home(),
      );
    });
  }
}

//ui
//newsapi recieving
//models
//dark mode
 

