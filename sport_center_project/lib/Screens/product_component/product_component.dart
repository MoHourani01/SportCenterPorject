import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/models/product_model.dart';

class flipWidget{
  final String image;
  final String title;

  flipWidget({
    required this.image,
    required this.title,
  });
}

var flipController = PageController();

List<flipWidget> flipper=[
  flipWidget(
    image: 'assets/images/Soccer.jpg',
    title: 'Price JD',),
  flipWidget(
    image: 'assets/images/basketball.jpg',
    title: 'hello',),
  flipWidget(
    image: 'assets/images/Soccer.jpg',
    title: 'Price JD',),
  flipWidget(
    image: 'assets/images/basketball.jpg',
    title: 'hello',),
  flipWidget(
    image: 'assets/images/basketball.jpg',
    title: 'hello',),
  flipWidget(
    image: 'assets/images/basketball.jpg',
    title: 'hello',),
  flipWidget(
    image: 'assets/images/basketball.jpg',
    title: 'hello',),
];
Widget cardFlippers(ProductsModel model,IconButton icon,{required Function() onPressed}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: FlipCard(
      fill: Fill.fillFront,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL,
      // default
      side: CardSide.FRONT,
      // The side to initially display.
      front: Stack(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Container(
              // height: 160,
              width: 220,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                      image: NetworkImage('${model.image}'), fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                      child: Container(
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3)),
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 10, bottom: 3),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              icon,
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    '${model.price}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 8),
                              //   child: InkWell(
                              //     onTap: cartOnPressed,
                              //     child: Icon(
                              //       Icons.shopping_cart_outlined,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0,top: 8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
              ),
            ),
          ),
        ],
      ),
      back: Card(
        color: Colors.transparent,
        elevation: 0,
        // shape: RoundedRectangleBorder(
        //   side: BorderSide(
        //     color: Colors.grey,
        //   ),
        // ),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              '${model.name}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
