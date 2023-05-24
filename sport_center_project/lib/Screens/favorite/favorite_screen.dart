import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/cart/Cart_Screen.dart';
import 'package:sport_center_project/Screens/cart/cart_service/cart_service.dart';
import 'package:sport_center_project/Screens/favorite/favorite_service/favorite_services.dart';
import 'package:sport_center_project/Screens/home/home_screen.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/Screens/product_component/product_service/product_service.dart';
import 'package:sport_center_project/Screens/product_details/product_details_screen.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';

class FavoriteScreen extends StatefulWidget {
  // List<ProductsModel> favorites=[]
  final List<ProductsModel> favorites;

  FavoriteScreen({Key? key, required this.favorites}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // const FavoriteScreen({Key? key}) : super(key: key);

  ProductsModel? product;

  List<ProductsModel> products = ProductsModel.products;

  // Future<void> addToCart(ProductsModel product) async {
  //   // get the current user
  //   final user = FirebaseAuth.instance.currentUser;
  //
  //   if (user == null) {
  //     // handle the case when no user is signed in
  //     return;
  //   }
  //
  //   // add the product to the cart
  //   await CartService().addToCart(user.uid, product, 1);
  // }


  ProductService productService=ProductService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProductsModel> favorites = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigators.navigatorWithBack(context, MainNavigationBar());
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Text('Wishlist'),
        centerTitle: true,
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
      body: StreamBuilder(
          stream: firestore
              .collection('users')
              .doc(user!.uid)
              .collection('favorites')
              .snapshots(),
          builder: (context,snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final favoriteProducts = snapshot.data!.docs.map((doc) {
              final product = ProductsModel.fromJson(doc.data()['productId']);
              product.isFavorite = true;
              return product;
            }).toList();

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    favoriteProducts.isEmpty
                        ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text(
                          'Your Wishlist Is Empty',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    )
                        :
                    SizedBox(
                      height: 20,
                    ),
                    MasonryGridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      // crossAxisSpacing:1,
                      mainAxisSpacing: 5,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: favoriteProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final product = ProductsModel.products[index];
                        final product = favoriteProducts[index];
                        // if (index >= favoriteProducts.length) {
                        //   return Container(); // Return an empty widget if index is out of bounds
                        // }
                        return cardFlippers(
                          favoriteProducts[index],
                          IconButton(
                            onPressed: user == null
                                ? null
                                : () async {
                              // toggle the isFavorite flag
                              setState(() {
                                favoriteProducts[index]!.isFavorite = !favoriteProducts[index]!.isFavorite;
                              });

                              // update the favorites collection
                              if (favoriteProducts[index]!.productId != null) {
                                await FavoriteService().toggleFavorite(favoriteProducts[index]!);
                                // await FavoriteService().removeFavorite(favoriteProducts[index]!);
                                // widget.favorites.remove(product);
                              } else {
                                print('error');
                              }
                            },
                            icon: Icon(
                              favoriteProducts[index]!.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: favoriteProducts[index]!.isFavorite
                                  ? Colors.red
                                  : Colors.red,
                            ),
                          ),
                          onPressed: () {
                            navigators.navigateTo(
                                context,
                                ProductDetail(
                                  product: product,
                                ));
                          },
                          // cartOnPressed: () {
                          //   if (CartService.instance.cartItems.any((item) => item.productId == favoriteProducts[index]!.productId)){
                          //     print('exists=> ${CartService.instance.cartItems.length}');
                          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       backgroundColor: Colors.grey.shade800,
                          //       content: Text('Product has already into cart list'),
                          //       duration: Duration(seconds: 2),
                          //       action: SnackBarAction(
                          //         textColor: Colors.white,
                          //         label: 'View',
                          //         onPressed: () {
                          //           navigators.navigatorWithBack(context, CartScreen());
                          //         },
                          //       ),
                          //     ));
                          //   }else{
                          //     addToCart(product!);
                          //     print('added=> ${CartService.instance.cartItems.length}');
                          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       backgroundColor: Colors.grey.shade800,
                          //       content: Text('Product added to cart'),
                          //       duration: Duration(seconds: 2),
                          //       action: SnackBarAction(
                          //         textColor: Colors.white,
                          //         label: 'View',
                          //         onPressed: () {
                          //           navigators.navigatorWithBack(context, CartScreen());
                          //         },
                          //       ),
                          //     ));
                          //   }
                          //   // addToCart(product);
                          // },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    // favorites = widget.favorites;
    user = auth.currentUser;
    auth.authStateChanges().listen((User? firebaseUser) {
      setState(() {
        user = firebaseUser;
      });
    });
  }
}
/*
StreamBuilder(
          stream: firestore
              .collection('users')
              .doc(user!.uid)
              .collection('favorites')
              .snapshots(),
          builder: (context,snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final favoriteProducts = snapshot.data!.docs.map((doc) {
              final product = ProductsModel.fromJson(doc.data()['Product']);
              product.isFavorite = true;
              return product;
            }).toList();

 */
var flipController = PageController();