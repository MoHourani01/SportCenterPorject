import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/basketball/basketball_layout/basketball_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/soccer/soccer_layout/soccer_screen.dart';

class CategoriesInfo extends StatefulWidget {
  const CategoriesInfo({Key? key}) : super(key: key);

  @override
  State<CategoriesInfo> createState() => _CategoriesInfoState();
}

class _CategoriesInfoState extends State<CategoriesInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Color(0xFF000056),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
          SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 120,
            // color: Colors.blue,
            decoration: BoxDecoration(
              color: Colors.grey.shade100.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                navigators.navigatorWithBack(context, soccer());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Soccer.jpg'),
                          fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                        ),
                      ),
                    ),
                    Text(
                      'Explore Our Soccer Collections',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF000056),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 120,
            // color: Colors.blue,
            decoration: BoxDecoration(
              color: Colors.grey.shade100.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                navigators.navigatorWithBack(context, basket());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/images/basketball.jpg'),
                          fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                        ),
                      ),
                    ),
                    Text(
                      'Explore Our basketball Collections',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF000056),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
