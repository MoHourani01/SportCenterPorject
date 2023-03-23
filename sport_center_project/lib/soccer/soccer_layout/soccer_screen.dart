import 'dart:ui';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/soccer/soccer_products/soccer_product_details/soccer_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget buildDisCoverCircle({image, title}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            child: PhysicalShape(
              color: Colors.white,
              shadowColor: Colors.black,
              clipBehavior: Clip.hardEdge,
              elevation: 3,
              clipper: ShapeBorderClipper(
                shape: CircleBorder(),
              ),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(image),
                )),
              ),
            ),
          ),
          SizedBox(height: 7.0),
          Text(
            title,
            style: TextStyle(
              color: Color(0xffadafaf),
            ),
          )
        ],
      ),
    );
  }

  // List<String> images = [
  //   "assets/images/basketball.jpg",
  //   "assets/images/basketball.jpg",
  //   "assets/images/basketball.jpg",
  //   "assets/images/basketball.jpg",
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff6f6f6),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff8275b3),
          ),
          onPressed: () {
            navigators.navigateTo(context, MainNavigationBar());
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              height: 30,
              width: 30,
              child: PhysicalShape(
                color: Colors.white,
                shadowColor: Colors.black,
                elevation: 3,
                clipper: ShapeBorderClipper(
                  shape: CircleBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        // shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Discover",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(
                        "Explore Our Collections",
                        style: TextStyle(color: Color(0xffa3a3a3)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Shot by",
                      style: TextStyle(
                        color: Color(0xff8275b3),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff8275b3),
                    )
                  ],
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 12.0),
          //   child: Text(
          //     "Explore Our Collections",
          //     style: TextStyle(color: Color(0xffa3a3a3)),
          //   ),
          // ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildDisCoverCircle(
                  image: 'assets/images/basketball.jpg',
                  title: "Woman",
                ),
                buildDisCoverCircle(
                  image: 'assets/images/basketball.jpg',
                  title: "Men",
                ),
                buildDisCoverCircle(
                  image: 'assets/images/basketball.jpg',
                  title: "Kid",
                ),
                buildDisCoverCircle(
                  image: 'assets/images/basketball.jpg',
                  title: "Shoes",
                ),
                buildDisCoverCircle(
                  image: 'assets/images/basketball.jpg',
                  title: "Shoes",
                ),
                buildDisCoverCircle(
                  image: 'assets/images/basketball.jpg',
                  title: "Shoes",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffb3a5de),
                ),
                hintText: "Search for products",
                hintStyle: TextStyle(
                  color: Color(0xffb3a5de),
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              // crossAxisSpacing: 5.0,
              mainAxisSpacing: 5,
              itemCount: 10,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (index >= flipper.length) {
                  return SizedBox
                      .shrink(); // Return an empty widget if index is out of bounds
                }
                return cardFlippers(
                  flipper[index],
                  IconButton(onPressed: (){}, icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.red,
                  ),),
                  onPressed: () {
                    setState(() {
                      navigators.navigateTo(context, Detail());
                    });
                  },
                );
              },
              // staggeredTileBuilder:
              // mainAxisSpacing: 20.0,
              // gridDelegate: null,),
            )),
        ],
      ),
    );
  }
}
