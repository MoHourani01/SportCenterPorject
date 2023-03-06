import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  // const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Cart Screen',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}