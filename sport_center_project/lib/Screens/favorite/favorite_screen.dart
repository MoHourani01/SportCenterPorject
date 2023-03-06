import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  // const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'favorite screen',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
