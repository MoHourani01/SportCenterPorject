import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/favorite/favorite_service/favorite_services.dart';
import 'package:sport_center_project/Screens/home/home_screen.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/soccer/soccer_products/soccer_product_details/soccer_details.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          navigators.navigatorWithBack(context, MainNavigationBar());
        }, icon: Icon(Icons.arrow_back),),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              widget.favorites.isEmpty
                  ? Center(
                      child: Text(
                      'Your Wishlist Is Empty',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
                  : MasonryGridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      // crossAxisSpacing:1,
                      mainAxisSpacing: 5,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: widget.favorites.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= widget.favorites.length) {
                          return Container(); // Return an empty widget if index is out of bounds
                        }
                        return cardFlippers(
                          widget.favorites[index],
                          IconButton(
                            onPressed: user == null
                                ? null
                                : () async {
                                    // toggle the isFavorite flag
                                    setState(() {
                                      widget.favorites[index].isFavorite =
                                          !widget.favorites[index].isFavorite;
                                    });

                                    // update the favorites collection
                                    if (widget.favorites[index].productId != null) {
                                      await FavoriteService()
                                          .toggleFavorite(widget.favorites[index]);
                                      // FavoriteService().addFavorite(products[index]);
                                      widget.favorites.removeAt(index);
                                    } else {
                                      print('error');
                                    }
                                  },
                            icon: Icon(
                              widget.favorites[index].isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: widget.favorites[index].isFavorite
                                  ? Colors.red
                                  : Colors.red,
                            ),
                          ),
                          onPressed: () {
                            navigators.navigateTo(context, SDetail());
                          },
                        );
                      },
                    ),
            ],
          ),
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

var flipController = PageController();

