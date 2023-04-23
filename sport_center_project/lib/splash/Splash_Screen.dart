import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sport_center_project/Screens/onBoarding_Screen/onBoarding.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    new Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => OnBoardingScreen()), (route) => false);
      });
    });

    new Timer(
        Duration(milliseconds: 10),(){
      setState(() {
        _isVisible = true; // Now it is showing fade effect and navigating to Login page
      });
    }
    );

  }

   @override
    Widget build(BuildContext context) {
      return AnimatedSplashScreen(
          pageTransitionType: PageTransitionType.fade,
          animationDuration: Duration(seconds: 2),
          backgroundColor: Colors.blueGrey.shade900.withOpacity(1),
          splash: Lottie.asset('assets/images/splash.json',),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 200,
          nextScreen: OnBoardingScreen());
  }
}