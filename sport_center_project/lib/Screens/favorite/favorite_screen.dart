import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sport_center_project/Screens/favorite/favorite_service/favorite_services.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/soccer/soccer_products/soccer_product_details/soccer_details.dart';


class FavoriteScreen extends StatefulWidget {
  List<ProductsModel> favorites=[];
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
                Color(0xFF130359),
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
              FavoriteScreen().favorites.isEmpty
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
                      itemCount: FavoriteScreen().favorites.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= FavoriteScreen().favorites.length) {
                          return Container(); // Return an empty widget if index is out of bounds
                        }
                        return cardFlippers(
                          FavoriteScreen().favorites[index],
                          IconButton(
                            onPressed: user == null
                                ? null
                                : () async {
                                    // toggle the isFavorite flag
                                    setState(() {
                                      FavoriteScreen().favorites[index].isFavorite =
                                          !FavoriteScreen().favorites[index].isFavorite;
                                    });

                                    // update the favorites collection
                                    if (FavoriteScreen().favorites[index].productId != null) {
                                      await FavoriteService()
                                          .toggleFavorite(FavoriteScreen().favorites[index]);
                                      // FavoriteService().addFavorite(products[index]);
                                    } else {
                                      print('error');
                                    }
                                  },
                            icon: Icon(
                              products[index].isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: products[index].isFavorite
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

