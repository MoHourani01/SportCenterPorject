import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/Screens/cart/Cart_Screen.dart';
import 'package:sport_center_project/Screens/category/Category_Screen.dart';
import 'package:sport_center_project/Screens/favorite/favorite_screen.dart';
import 'package:sport_center_project/Screens/profile/Profile_Screen.dart';

class MainNavigationBar extends StatefulWidget {
  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  // const MainNavigationBar({Key? key}) : super(key: key);
  int page = 0;
  List<Widget> screens = [
    CategoryScreen(),
    FavoriteScreen(),
    ProfileScreen(),
    CartScreen(),

  ];

  // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        items: [
          BottomNavigationBarItem
            (
            icon: Icon(
                Icons.category,
              color: Colors.blue,
            ),
          label: 'Category',
          ),
          BottomNavigationBarItem
            (
            icon: Icon(
                Icons.favorite,
              color: Colors.red,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem
            (
            icon: Icon(Icons.person,color: Colors.blue,),
            label: 'Profile',
          ),
          BottomNavigationBarItem
            (
            icon: Icon(Icons.shopping_cart,color: Colors.grey,),
            label: 'Cart',
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
