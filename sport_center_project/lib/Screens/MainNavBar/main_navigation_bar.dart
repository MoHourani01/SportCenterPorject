import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/cart/Cart_Screen.dart';
import 'package:sport_center_project/Screens/category/Category_Screen.dart';
import 'package:sport_center_project/Screens/favorite/favorite_screen.dart';
import 'package:sport_center_project/Screens/home/home_screen.dart';
import 'package:sport_center_project/Screens/profile/Profile_Screen.dart';

class MainNavigationBar extends StatefulWidget {
  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  // const MainNavigationBar({Key? key}) : super(key: key);
  int page = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),

  ];

  // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[page],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeOut,
        index: 0,
        backgroundColor: Colors.white,
        color: Color(0xFF012605),
        height: 60,
        // currentIndex: page,
        items: [
          Icon(
              Icons.home,
              color: Colors.green[100],
            ),
          Icon(
            Icons.category,
            color: Colors.green[100],
          ),
          Icon(
            Icons.favorite,
            color: Colors.green[100],
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.green[100],
          ),
          Icon(
            Icons.person,
            color: Colors.green[100],
          ),
        ],
        onTap: (index){
          setState(() {
            page=index;
          });
        },
      ),
    );
  }
}
