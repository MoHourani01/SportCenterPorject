import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/models/products_model/prodcuts_model.dart';

class ProductsCardView extends StatefulWidget {
  ProductsCardView({
    Key? key,
    // required this.productsModel,
  }) : super(key: key);
  ProductModel? productsModel;

  @override
  State<ProductsCardView> createState() => _ProductsCardViewState();
}

class _ProductsCardViewState extends State<ProductsCardView> {
  // ProductsService productsService = ProductsService();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(
                  image: AssetImage('${widget.productsModel!.productImage!}'),
                  fit: BoxFit.cover)),
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
                      decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 37, right: 15),
                                  child: Text(
                                    '${widget.productsModel!.productPrice.toString()} JD',
                                    style: const TextStyle(
                                        fontFamily: 'Georgia',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.add_shopping_cart_outlined,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
