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

class flipWidget {
  final String image;
  final String title;

  flipWidget({
    required this.image,
    required this.title,
  });
}

class FavoriteScreen extends StatefulWidget {
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
              products.isEmpty
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
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= products.length) {
                          return Container(); // Return an empty widget if index is out of bounds
                        }
                        return cardFlippers(
                          products[index],
                          IconButton(
                            onPressed: user == null
                                ? null
                                : () async {
                                    // toggle the isFavorite flag
                                    setState(() {
                                      products[index].isFavorite =
                                          !products[index].isFavorite;
                                    });

                                    // update the favorites collection
                                    if (products[index].productId != null) {
                                      await FavoriteService()
                                          .toggleFavorite(products[index]);
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

// List<flipWidget> flipper = [
//   flipWidget(
//     image: 'assets/images/Soccer.jpg',
//     title: 'Price JD',
//   ),
//   flipWidget(
//     image: 'assets/images/basketball.jpg',
//     title: 'hello',
//   ),
//   flipWidget(
//     image: 'assets/images/Soccer.jpg',
//     title: 'Price JD',
//   ),
//   flipWidget(
//     image: 'assets/images/basketball.jpg',
//     title: 'hello',
//   ),
//   flipWidget(
//     image: 'assets/images/basketball.jpg',
//     title: 'hello',
//   ),
//   flipWidget(
//     image: 'assets/images/basketball.jpg',
//     title: 'hello',
//   ),
//   flipWidget(
//     image: 'assets/images/basketball.jpg',
//     title: 'hello',
//   ),
// ];

//   Widget cardFlippers(flipWidget flipper, IconButton icon,
//       {required Function() onPressed}) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       child: FlipCard(
//         fill: Fill.fillFront,
//         // Fill the back side of the card to make in the same size as the front.
//         direction: FlipDirection.HORIZONTAL,
//         // default
//         side: CardSide.FRONT,
//         // The side to initially display.
//         front: Stack(
//           children: [
//             Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(
//                   color: Colors.grey,
//                 ),
//                 borderRadius: const BorderRadius.all(Radius.circular(6)),
//               ),
//               child: Container(
//                 // height: 160,
//                 width: 220,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6.0),
//                     image: DecorationImage(
//                         image: AssetImage('${flipper.image}'),
//                         fit: BoxFit.cover)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(6.0),
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
//                         child: Container(
//                           height: 36,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.3)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10, bottom: 3),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 icon,
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 3),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Text(
//                                       '${flipper.title}',
//                                       style: const TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 8),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Icon(
//                                       Icons.shopping_cart_outlined,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 onPressed: onPressed,
//                 icon: Icon(Icons.arrow_forward),
//               ),
//             ),
//           ],
//         ),
//         back: Card(
//           color: Colors.transparent,
//           elevation: 0,
//           // shape: RoundedRectangleBorder(
//           //   side: BorderSide(
//           //     color: Colors.grey,
//           //   ),
//           // ),
//           child: Container(
//             height: 160,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: Colors.grey,
//             ),
//             child: Center(
//               child: Text(
//                 'Sport Center',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
