
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sport_center_project/Screens/onBoarding_Screen/onBoarding.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState(){}

   @override
    Widget build(BuildContext context) {
      return AnimatedSplashScreen(
        pageTransitionType: PageTransitionType.fade,
        animationDuration: Duration(milliseconds: 750),
        backgroundColor: Colors.transparent,
        splash: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/splash.jpg',
            fit: BoxFit.cover,
          ),
        ),
        splashTransition: SplashTransition.scaleTransition,
        splashIconSize: 350,
        nextScreen: OnBoardingScreen(),
      );
   }
}