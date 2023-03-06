import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}