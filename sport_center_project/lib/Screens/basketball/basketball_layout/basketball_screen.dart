import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/basketball/basketball_products/basketball_product_details/basketball_details.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/soccer/soccer_products/soccer_product_details/soccer_details.dart';

class basket extends StatefulWidget {
  const basket({Key? key}) : super(key: key);

  @override
  _basketState createState() => _basketState();
}

class flipWidget{
  final String image;
  final String title;

  flipWidget({
    required this.image,
    required this.title,
  });
}

class _basketState extends State<basket> {
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
              color: Colors.orangeAccent.shade400,
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
            color: Colors.brown,
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
                      "Basket ball",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(
                        "Explore Our Basketball Collections",
                        style: TextStyle(color:Colors.brown),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Text(
                    //   "Sort by",
                    //   style: TextStyle(
                    //     color: Color(0xff8275b3),
                    //   ),
                    // ),
                    Container(
                      color:  Colors.brown,
                      child: Icon(
                        Icons.sports_basketball,
                        size: 40.0,
                        color: Colors.orangeAccent.shade400,
                      ),
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
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        navigators.navigateTo(context, BDetail());
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

  var flipController = PageController();

  List<flipWidget> flipper = [
    flipWidget(
      image: 'assets/images/Soccer.jpg',
      title: 'Price JD',
    ),
    flipWidget(
      image: 'assets/images/basketball.jpg',
      title: 'hello',
    ),
    flipWidget(
      image: 'assets/images/Soccer.jpg',
      title: 'Price JD',
    ),
    flipWidget(
      image: 'assets/images/basketball.jpg',
      title: 'hello',
    ),
    flipWidget(
      image: 'assets/images/basketball.jpg',
      title: 'hello',
    ),
    flipWidget(
      image: 'assets/images/basketball.jpg',
      title: 'hello',
    ),
    flipWidget(
      image: 'assets/images/basketball.jpg',
      title: 'hello',
    ),
  ];

  Widget cardFlippers(flipWidget flipper, IconButton icon,
      {required Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: FlipCard(
        fill: Fill.fillFront,
        // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.HORIZONTAL,
        // default
        side: CardSide.FRONT,
        // The side to initially display.
        front: Stack(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Container(
                // height: 160,
                width: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                        image: AssetImage('${flipper.image}'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                        child: Container(
                          height: 36,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                icon,
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      '${flipper.title}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                    ),
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
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
        back: Card(
          color: Colors.transparent,
          elevation: 0,
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(
          //     color: Colors.grey,
          //   ),
          // ),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey,
            ),
            child: Center(
              child: Text(
                'Sport Center',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
