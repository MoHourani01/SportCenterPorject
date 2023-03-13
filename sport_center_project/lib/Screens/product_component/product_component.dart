import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

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
];
Widget cardFlippers(flipWidget flip,Icon icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: FlipCard(
      fill: Fill.fillFront,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL,
      // default
      side: CardSide.FRONT,
      // The side to initially display.
      front: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(
                  image: AssetImage('${flip.image}'), fit: BoxFit.cover)),
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
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: InkWell(
                                onTap: () {},
                                child: icon,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                '${flip.title}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      back: Card(
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
              'Sport Center',
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
