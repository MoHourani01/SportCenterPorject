import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';

class FavoriteScreen extends StatelessWidget {
  // const FavoriteScreen({Key? key}) : super(key: key);

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
        child: Column(
          children: [
            SizedBox(height: 20,),
            MasonryGridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                // crossAxisSpacing:1,
                mainAxisSpacing: 5,
                primary: false,
                shrinkWrap: true,
                itemCount:5,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= flipper.length) {
                    return SizedBox.shrink(); // Return an empty widget if index is out of bounds
                  }
                  return cardFlippers(flipper[index],Icon(
                    Icons.favorite,
                    color: Colors.red,
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
