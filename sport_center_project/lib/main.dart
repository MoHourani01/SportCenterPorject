import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/home/home_screen.dart';
import 'package:sport_center_project/splash/Splash_Screen.dart';

import 'Screens/onBoarding_Screen/onBoarding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        // useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // title: 'Flutter',
      // home: SplashScreen(title:'login'),
      home:MainNavigationBar(),
    );
  }
}


