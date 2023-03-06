import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/Home/home_screen.dart';
import 'package:sport_center_project/splash/Splash_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: _primaryColor,
        // accentColor: _accentColor,
      ),
      debugShowCheckedModeBanner: false,
      // title: 'Flutter',
      // home: SplashScreen(title:'login'),
      home: MainNavigationBar(),
    );
  }
}


