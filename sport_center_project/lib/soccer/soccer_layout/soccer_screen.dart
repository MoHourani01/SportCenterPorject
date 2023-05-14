import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/basketball/basketball_products/basketball_product_details/basketball_details.dart';
import 'package:sport_center_project/Screens/cart/Cart_Screen.dart';
import 'package:sport_center_project/Screens/cart/cart_service/cart_service.dart';
import 'package:sport_center_project/Screens/favorite/favorite_screen.dart';
import 'package:sport_center_project/Screens/favorite/favorite_service/favorite_services.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/Screens/product_details/product_details_screen.dart';
import 'package:sport_center_project/Screens/search/search.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';

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

  // final List<ProductsModel> products = ProductsModel.soccer_products;
  List<ProductsModel> filteredItems = [];

  Future<void> addToCart(ProductsModel product) async {
    // CartService.instance.cartItems.add(product);
    // get the current user
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // handle the case when no user is signed in
      return;
    }

    // add the product to the cart
    await CartService().addToCart(user.uid, product, 1);
  }
  TextEditingController searchController=TextEditingController();
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

  void filterSearchResults(String query) {
    setState(() {
      filteredItems = SearchUtils.filterSearchResults(query, products);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            elevation: 0,
            // expandedHeight: 200,
            backgroundColor: Color(0xFF030A59),
            leading: IconButton(
              onPressed: () {
                navigators.navigateTo(context, MainNavigationBar());
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigators.navigateTo(context, FavoriteScreen(favorites: favorites));
                },
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  // color: Color(0xFF130359),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF030A59),
                      Color(0xF717217A),
                      Color(0xFF1D2EA8),
                    ],
                    begin: AlignmentDirectional.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              title: Text('Soccer'),
              centerTitle: true,
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
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
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                "Explore Our Soccer Collections",
                                style: TextStyle(
                                  color: Color(0xF717217A),
                                  fontSize: 17.0,
                                ),
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
                              height:50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:  Colors.grey,
                              ),
                              child: Icon(
                                size: 40,
                                Icons.sports_soccer,
                                color: Colors.white,
                              ),
                            ),
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
                          image: 'assets/images/Soccer.jpg',
                          title: "All",
                        ),
                        buildDisCoverCircle(
                          image: 'assets/images/soccer_shoes.jpg',
                          title: "Shoes",
                        ),
                        buildDisCoverCircle(
                          image: 'assets/images/soccer_shirts.png',
                          title: "Shirts",
                        ),
                        buildDisCoverCircle(
                          image: 'assets/images/soccer_equ.jpg',
                          title: "Equipments",
                        ),
                        buildDisCoverCircle(
                          image: 'assets/images/soccer_ball.jpg',
                          title: "Balls",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
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
                      itemCount: filteredItems.length, // use products length here
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final product = ProductsModel.soccer_products[index];
                        if (index >= products.length) { // check if index is out of range
                          return Container(); // Return an empty widget if index is out of bounds
                        }
                        return cardFlippers(
                            filteredItems[index],
                            IconButton(
                              onPressed: user == null ? null : () async {
                                // toggle the isFavorite flag
                                setState(() {
                                  filteredItems[index].isFavorite = !filteredItems[index].isFavorite;
                                });

                                // update the favorites collection
                                if (filteredItems[index].productId != null) {
                                  await FavoriteService().toggleFavorite(filteredItems[index]);
                                  toggleFavorite(index);
                                  FavoriteScreen(favorites: favorites);
                                  if (favorites.length > 0) {
                                    print(favorites);
                                  }
                                  print(favorites.length);
                                } else {
                                  print('error');
                                }
                              },
                              icon: Icon(
                                filteredItems[index].isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                navigators.navigatorWithBack(context, ProductDetail(product: product,));
                              });
                            },
                            // cartOnPressed: (){
                            //   // if (CartService.instance.cartItems.any((item) => item.productId == product.productId)){
                            //   //   print('exists=> ${CartService.instance.cartItems.length}');
                            //   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   //     backgroundColor: Colors.grey.shade800,
                            //   //     content: Text('Product has already added into cart list'),
                            //   //     duration: Duration(seconds: 2),
                            //   //     action: SnackBarAction(
                            //   //       textColor: Colors.white,
                            //   //       label: 'View',
                            //   //       onPressed: () {
                            //   //         navigators.navigatorWithBack(context, CartScreen());
                            //   //       },
                            //   //     ),
                            //   //   ));
                            //   // }else{
                            //   addToCart(product);
                            //   // print('added=> ${CartService.instance.cartItems.length}');
                            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     backgroundColor: Colors.grey.shade800,
                            //     content: Text('Product added to cart'),
                            //     duration: Duration(seconds: 2),
                            //     action: SnackBarAction(
                            //       textColor: Colors.white,
                            //       label: 'View',
                            //       onPressed: () {
                            //         navigators.navigatorWithBack(context, CartScreen());
                            //       },
                            //     ),
                            //   ));
                            // }
                          // addToCart(product);
                          // },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    filteredItems.addAll(products);
    user = auth.currentUser;
    auth.authStateChanges().listen((User? firebaseUser) {
      setState(() {
        user = firebaseUser;
      });
    });
  }
}