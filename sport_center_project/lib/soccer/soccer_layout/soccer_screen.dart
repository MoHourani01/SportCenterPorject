import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/basketball/basketball_products/basketball_product_details/basketball_details.dart';
import 'package:sport_center_project/Screens/favorite/favorite_screen.dart';
import 'package:sport_center_project/Screens/favorite/favorite_service/favorite_services.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/soccer/soccer_products/soccer_product_details/soccer_details.dart';

class soccer extends StatefulWidget {
  const soccer({Key? key}) : super(key: key);

  @override
  _soccerState createState() => _soccerState();
}


class _soccerState extends State<soccer> {

  bool isFavorite = false;
  ProductsModel? product;

  List<ProductsModel> products = ProductsModel.soccer_products;
  List<ProductsModel> favorites = [];

  void toggleFavorite(int index) {
    setState(() {
      if (products[index].isFavorite) {
        favorites.add(products[index]);
      } else {
        favorites.remove(products[index]);
      }
      FavoriteScreen(favorites: favorites,);
    });
  }
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
              color:Colors.black26,
            ),
          )
        ],
      ),
    );
  }


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
            color:  Color(0xF717217A),
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
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
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
                        "Soccer",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF130359),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Text(
                          "Explore Our Soccer Collections",
                          style: TextStyle(color: Color(0xF717217A)),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:  Colors.grey,
                        ),
                        child: Icon(
                          Icons.sports_soccer_outlined,
                          size: 40.0,
                          color: Colors.black,
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
                    color:Color(0xF717217A),
                  ),
                  hintText: "Search for products",
                  hintStyle: TextStyle(
                    color:Colors.grey,
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
                mainAxisSpacing: 5,
                itemCount: products.length, // use products length here
                primary: false,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= products.length) { // check if index is out of range
                    return Container(); // Return an empty widget if index is out of bounds
                  }
                  return cardFlippers(
                    products[index],
                    IconButton(
                      onPressed: user == null ? null : () async {
                        // toggle the isFavorite flag
                        setState(() {
                          products[index].isFavorite = !products[index].isFavorite;
                        });

                        // update the favorites collection
                        if (products[index].productId != null) {
                          await FavoriteService().toggleFavorite(products[index]);
                          toggleFavorite(index);
                          if (favorites.length > 0) {
                            print(favorites);
                          }
                          print(favorites.length);
                        } else {
                          print('error');
                        }
                      },
                      icon: Icon(
                        products[index].isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        navigators.navigatorWithBack(context, SDetail());
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    auth.authStateChanges().listen((User? firebaseUser) {
      setState(() {
        user = firebaseUser;
      });
    });
  }
}
