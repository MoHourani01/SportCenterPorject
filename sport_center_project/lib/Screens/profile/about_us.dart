import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/profile/Profile_Screen.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';


class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'about us',
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF030A59),
                  Color(0xFF121879),
                  Color(0xFF2931A8),
                ],
                begin: AlignmentDirectional.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: buildBoardingItem(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem() => Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 430,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                  image: AssetImage('assets/images/soccer_basketballl.jpg'),
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.grey, BlendMode.darken))),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Text(
                'Sport Center',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.blue.shade900.withOpacity(1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Our app offers a wide selection of high-quality soccer and basketball products from the best brands, with fast and reliable shipping. Shop now and get everything you need to succeed on the field or court! you will never regret it.',
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}