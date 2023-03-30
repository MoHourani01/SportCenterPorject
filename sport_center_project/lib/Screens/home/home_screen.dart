import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/Screens/favorite/favorite_service/favorite_services.dart';
import 'package:sport_center_project/Screens/home/categories_info/categories_info.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/cubit/cubit.dart';
import 'package:sport_center_project/cubit/states.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/soccer/soccer_products/soccer_product_details/soccer_details.dart';

// class flipWidget{
//   final String image;
//   final String title;
//
//   flipWidget({
//     required this.image,
//     required this.title,
//   });
// }

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({Key? key}) : super(key: key);
  // final List<Color> colors = [    Colors.red,    Colors.orange,    Colors.yellow,    Colors.green,    Colors.blue,    Colors.purple,  ];
  final List<String> images = [
    'assets/images/Soccer.jpg',
    'assets/images/basketball.jpg'
  ];
  final List<String> texts = ['Football', 'Basketball'];
  final List<String> items = ['All', 'Shoes', 'Shirts', 'Equipments', 'Balls'];
  var flipController = PageController();


  final carouselController = CarouselController();
  int indexItems = 0;
  int activatedIndex = 0;
  bool isBottomSheet = false;

  var formKey = GlobalKey<FormState>();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFavorite = false;
  ProductsModel? product;

  List<ProductsModel> products = ProductsModel.products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (isBottomSheet) {
              Navigator.of(context).pop();
              isBottomSheet = false;
            } else {
              scaffoldKey.currentState!.showBottomSheet(
                    (context) {
                  isBottomSheet = true;
                  return CategoriesInfo();
                },
              );
            }
          });
        },
        tooltip: 'Categories',
        backgroundColor: Color(0xFF130359).withOpacity(0.8),
        child: Icon(Icons.category),
      ),
      backgroundColor: Colors.grey.shade300,
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
            backgroundColor: Color(0xFF130359),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Sport Center',
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
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
                      Color(0xFF130359),
                      Color(0xF717217A),
                      Color(0xFF1D2EA8),
                    ],
                    begin: AlignmentDirectional.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              title: Text('Sport Center'),
              centerTitle: true,
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  CarouselSlider(
                    items: images
                        .map(
                          (e) => Image(
                        image: AssetImage('${e}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      // aspectRatio: 10/6,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) =>
                          setState(() => activatedIndex = index),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  buildIndicator(),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < items.length; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexItems = i;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: indexItems == i
                                        ? Color(0xFF320C72).withOpacity(1)
                                        : Colors.white70,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  items[i],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: items[i] == items[indexItems]
                                        ? Colors.white
                                        : Colors.blueGrey.shade900
                                        .withOpacity(1),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),

                  MasonryGridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 5,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= products.length) {
                          return SizedBox
                              .shrink(); // Return an empty widget if index is out of bounds
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
                                }else{
                                print('error');
                                }
                              },
                            icon: Icon(
                              products[index].isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                              color: products[index].isFavorite ? Colors.red : Colors.red,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              navigators.navigateTo(context, sDetail());
                            });
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activatedIndex,
      count: images.length,
      onDotClicked: animateToSlide,
      effect: SlideEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Colors.blue.shade900.withOpacity(1),
          dotColor: Colors.grey),
    );
  }

  void animateToSlide(int index) => carouselController.animateToPage(index);

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
