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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/Screens/cart/Cart_Screen.dart';
import 'package:sport_center_project/Screens/cart/cart_service/cart_service.dart';
import 'package:sport_center_project/Screens/favorite/favorite_screen.dart';
import 'package:sport_center_project/Screens/favorite/favorite_service/favorite_services.dart';
import 'package:sport_center_project/Screens/home/categories_info/categories_info.dart';
import 'package:sport_center_project/Screens/news/News_Screen.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/Screens/product_component/product_service/product_service.dart';
import 'package:sport_center_project/Screens/product_details/product_details_screen.dart';
import 'package:sport_center_project/Screens/profile/Profile_Screen.dart';
import 'package:sport_center_project/Screens/profile/about_us.dart';
import 'package:sport_center_project/Screens/profile/chatbot/chatbot_screen.dart';
import 'package:sport_center_project/Utilities/VariablesUtils.dart';
import 'package:sport_center_project/cubit/cubit.dart';
import 'package:sport_center_project/cubit/states.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_cubit.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({Key? key}) : super(key: key);
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
  // bool isFavorite = false;

  List<ProductsModel> products = ProductsModel.products;

  List<ProductsModel> favorites = [];

  // void toggleFavorite(int index) {
  //   setState(() {
  //     if (products[index].isFavorite) {
  //       favorites.add(products[index]);
  //     } else {
  //       favorites.remove(products[index]);
  //     }
  //     FavoriteScreen(favorites: favorites,);
  //   });
  // }
  void toggleFavorite(int index, ProductsList productsList) async{
    setState(() {
      final product = productsList.posts[index];
      if (product.isFavorite) {
        favorites.add(product);
      } else {
        favorites.remove(product);
      }
      FavoriteScreen(favorites: favorites);
    });
  }

  // void toggleFavorite(int index, ProductsList productsList) async {
  //   setState(() {
  //     final product = productsList.posts[index];
  //     if (product.isFavorite) {
  //       favorites.add(product);
  //       FavoriteService().addFavorite(product);
  //
  //     } else {
  //       favorites.remove(product);
  //       FavoriteService().removeFavorite(product);
  //     }
  //     FavoriteScreen(favorites: favorites);
  //   });
  // }

  ProductService productService=ProductService();

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

  // List<ProductsModel> cartItems=[];
  // ProductsList? productsList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductsList>(
        stream: productService.getPosts('products'),
        builder: (context, snapshot){
          // if (snapshot.hasError) {
          //   // return Text('Error: ${snapshot.error}')Text('Error: ${snapshot.error}');
          //   return Center(child: CircularProgressIndicator());
          // }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }
          // final productsModel = ProductsModel();
          // snapshot.data!.docs.forEach((doc) {
          //   productsModel.addProductFromFirebase(doc);
          // });
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            ProductsList productsList = snapshot.data!;
            return Scaffold(
              key: scaffoldKey,
              drawer: Drawer(
                width: 220,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: Color(0xFF030A59),
                      ),
                      child: Center(
                        child: Text('MENU',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF030A59),
                            ),
                            child: TextButton(
                              onPressed: (){
                                navigators.navigatorWithBack(context, ProfileScreen());
                              },
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight:  FontWeight.bold,
                                  color:  Colors.white,
                                ),
                              ),

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF030A59),
                            ),
                            child: TextButton(
                              onPressed: (){
                                navigators.navigatorWithBack(context, ChatbotScreen());
                              },
                              child: Text(
                                "ChatBot",
                                style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight:  FontWeight.bold,
                                  color:  Colors.white,
                                ),
                              ),

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF030A59),
                            ),
                            child: TextButton(
                              onPressed: (){
                                navigators.navigatorWithBack(context, about());
                              },
                              child: Text(
                                "About Us",
                                style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight:  FontWeight.bold,
                                  color:  Colors.white,
                                ),
                              ),

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xEEE7CCD1),
                            ),
                            child: TextButton(
                              onPressed: (){
                                LoginCubit.get(context)
                                    .logout()
                                    .then((value) =>
                                    navigators.navigateTo(
                                        context, LoginScreen()))
                                    .whenComplete(() =>
                                    showToast(
                                        text: 'Logged out',
                                        state: ToastStates.Success));
                              },
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                    fontSize: 16,
                                    // fontWeight:  FontWeight.bold,
                                    color:  Colors.red.shade800
                                ),
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                backgroundColor: Color(0xFF030A59).withOpacity(0.8),
                heroTag: 'cate',
                child: Icon(Icons.category),
              ),
              backgroundColor: Colors.grey.shade300,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: Color(0xFF030A59),
                    leading: IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    // title: Text(
                    //   'Sport Center',
                    // ),
                    // centerTitle: true,
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
                    floating: true,
                    pinned: true,
                    expandedHeight: 145,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
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
                            items: products.take(4)
                                .map(
                                  (e) => Image(
                                image: NetworkImage('${e.image}'),
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
                              enlargeFactor: 2.3,
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
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Categories',
                                    style: TextStyle(
                                      // fontFamily: 'Georgia',
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xF717217A),
                                    ),
                                  ),
                                ),
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
                                                    ? Color(0xF70A1673).withOpacity(1)
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
                            ],
                          ),
                          SizedBox(height: 8,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0,left:12.0),
                                child: Text(
                                  'Products',
                                  style: TextStyle(
                                    // fontFamily: 'Georgia',
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xF717217A),
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
                                  itemCount:productsList.posts.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // final product = ProductsModel.products[index];
                                    ProductsModel productt = productsList.posts[index];
                                    if (index >= productsList.posts.length) {
                                      return SizedBox
                                          .shrink(); // Return an empty widget if index is out of bounds
                                    }
                                    return cardFlippers(
                                      productt,
                                      // IconButton(
                                      //   onPressed: user == null ? null : () async {
                                      //     // toggle the isFavorite flag
                                      //     setState(() {
                                      //       productt.isFavorite = !productt.isFavorite;
                                      //     });
                                      //
                                      //     // update the favorites collection
                                      //     if (productt.productId != null) {
                                      //       await FavoriteService().toggleFavorite(productt);
                                      //       // FavoriteService().addFavorite(products[index]);
                                      //       toggleFavorite(index,productsList);
                                      //       FavoriteScreen(favorites: favorites);
                                      //       // setState(() {
                                      //       //   productt.isFavorite = favorites.any((fav) => fav.productId == productt.productId);
                                      //       // });
                                      //       bool isFavorite = await FavoriteService().isFavorite(productt);
                                      //       setState(() {
                                      //         productt.isFavorite = isFavorite;
                                      //       });
                                      //       if(favorites.length>0){
                                      //         print(favorites);
                                      //         // print(favorites[index]);
                                      //       }
                                      //       print(productsList);
                                      //       print(favorites.length);
                                      //     }else{
                                      //       print('error');
                                      //     }
                                      //   },
                                      //   icon: Icon(
                                      //     productt.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                                      //     color: productt.isFavorite ? Colors.red : Colors.red,
                                      //   ),
                                      // ),
                                      IconButton(
                                        onPressed: user == null ? null : () async {
                                          // toggle the isFavorite flag
                                          setState(() {
                                            productt.isFavorite = !productt.isFavorite;
                                          });

                                          // update the favorites collection
                                          if (productt.productId != null) {
                                            await FavoriteService().toggleFavorite(productt);
                                            // toggleFavorite(index, productsList);
                                            // toggleFavorite(index, );
                                            // FavoriteScreen(favorites: favorites);
                                            // print(favorites.length);
                                          }
                                        },
                                        icon: Icon(
                                          productt.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                                          color: productt.isFavorite
                                              ? Colors.red
                                              : Colors.red,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductDetail(product:productt),
                                            ),
                                          );
                                        });
                                      },
                                      // cartOnPressed: () {
                                      //   // controleQuantity(1);
                                      //   // if (CartService.instance.cartItems.any((item) => item.productId == productt.productId)){
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
                                      //   addToCart(productt);
                                      //   // print('added=> ${CartService.instance.cartItems.length}');
                                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      //     backgroundColor: Colors.grey.shade800,
                                      //     content: Text('Product ${productt.name} added to cart'),
                                      //     duration: Duration(seconds: 2),
                                      //     action: SnackBarAction(
                                      //       textColor: Colors.white,
                                      //       label: 'View',
                                      //       onPressed: () {
                                      //         navigators.navigatorWithBack(context, CartScreen());
                                      //       },
                                      //     ),
                                      //   ));
                                      // },
                                      // },
                                    );
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
    );
  }



  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activatedIndex,
      count: 4,
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