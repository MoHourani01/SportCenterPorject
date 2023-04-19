import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sport_center_project/Screens/cart/cart_service/cart_service.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // const FavoriteScreen({Key? key}) : super(key: key);

  List<String> myCart=[
    'assets/images/basketball.jpg',
    'assets/images/Soccer.jpg',
    'assets/images/basketball.jpg',
    'assets/images/Soccer.jpg',
  ];

  List<String> stringCart=[
    'basketball',
    'soccer',
    'basketball',
    'soccer',
  ];

  int counter=0;
  final CartService _cartService = CartService();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Text('Cart'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFF030A59),
                Color(0xFF121879),
                Color(0xFF2931A8),
              ],
              begin: AlignmentDirectional.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CartList(),
          ],
        ),
      ),
    );
  }

  Widget CartList(){
    return MasonryGridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 1,
        crossAxisSpacing: 1,
        mainAxisSpacing: 5,
        primary: false,
        shrinkWrap: true,
        itemCount:myCart.length,
        itemBuilder: (context, index){
          if (index >= myCart.length) {
            return SizedBox.shrink(); // Return an empty widget if index is out of bounds
          }
          return CartItems(context, index);
    });
  }

  Widget CartItems(context, index){
    return Dismissible(
      key: Key(myCart[index]),
      onDismissed: (direction){
        var cartItem=myCart[index];
        showSnackBar(context, index, cartItem);
        setState(() {
          myCart.removeAt(index);
        });
      },
      background: deleteCartItem(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade300,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 275,
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
                          // height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              image: DecorationImage(
                                  image: AssetImage('${myCart[index]}'), fit: BoxFit.cover)),
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
                                                child: Icon(Icons.favorite_border_outlined,color: Colors.red,),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Text(
                                                '${stringCart[index]}',
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
                        color: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          height: 120,
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
                  ),
                  SizedBox(width: 15,),
                  Container(
                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          child: FloatingActionButton(
                            heroTag: '+',
                            onPressed: (){
                              setState(() {
                                counter++;
                                print(counter);
                              });
                            },
                            mini: true,
                            backgroundColor: Color(0xFF17299F),
                            child: Icon(Icons.add,color: Colors.white,size: 20,),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text('$counter'),
                        SizedBox(width: 8,),
                        Container(
                          height: 30,
                          width: 30,
                          child: FloatingActionButton(
                            heroTag: '-',
                            onPressed: (){
                              setState(() {
                                if (counter<=0){
                                  counter=0;
                                  print(counter);
                                }
                                else{
                                  counter--;
                                  print(counter);
                                }
                              });
                            },
                            mini: true,
                            backgroundColor: Color(0xFF17299F),
                            child: FaIcon(
                              FontAwesomeIcons.minus,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showSnackBar(context,index,cartItem){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Your product ${index} has been deleted successfully',
            ),
          action: SnackBarAction(label: 'UNDO', onPressed: (){
            undoProduct(index, cartItem);
          }),
        ),
    );
  }

  undoProduct(index,cartItem){
    setState(() {
      myCart.insert(index, cartItem);
    });
  }

  Widget deleteCartItem(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
        ),
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete,color: Colors.white,),
      ),
    );
  }
}