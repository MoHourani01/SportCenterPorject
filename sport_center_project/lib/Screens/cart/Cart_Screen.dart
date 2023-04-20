import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sport_center_project/Screens/cart/cart_service/cart_service.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:sport_center_project/models/product_model.dart';

final _firestore = FirebaseFirestore.instance;
class CartScreen extends StatefulWidget {
  ProductsModel? product;
   //
   CartScreen({this.product});
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
  final CartService cartService = CartService();
  List<ProductsModel> cartItems = CartService().cartItems;
  // final auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    _getProductQuantityFromCart();
  }

  void _getProductQuantityFromCart() async {
    if (widget.product == null) {
      return;
    }
    final quantity = await cartService.getProductQuantityFromCart(widget.product!.productId!);
    setState(() {
      counter = quantity;
    });
  }


  @override
  Widget build(BuildContext context) {
    final user =FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').doc(user!.uid).collection('cart').snapshots(),
        builder: (context,snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
              ),
            );
          }
          final data = snapshot.data!.docs;
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
                data.isEmpty
                    ? Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text(
                      'Your Cart Is Empty',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                )
                    :
                // CartList(),
                MasonryGridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5,
                    primary: false,
                    shrinkWrap: true,
                    itemCount:data.length,
                    itemBuilder: (context, index){
                      var cartModel = ProductsModel(
                          name: data[index].get('name'),
                          image: data[index].get('image'),
                          price: data[index].get('price'),
                          productId: data[index].get('productId'),
                          description: data[index].get('description'),
                          quantity: data[index].get('quantity'));
                      if (index >= data.length) {
                        return SizedBox
                            .shrink(); // Return an empty widget if index is out of bounds
                      }
                      return Dismissible(
                        key: Key(data.toString()),
                        onDismissed: (direction) async {
                          data[index].reference.delete();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text('Your product ${cartModel.name} has been deleted successfully'),
                            duration: Duration(seconds: 2),
                            action: SnackBarAction(
                              textColor: Colors.blue,
                              label: 'Undo',
                              onPressed: () {
                                // navigators.navigatorWithBack(context, CartScreen());
                              },
                            ),
                          ));
                          // final user = FirebaseAuth.instance.currentUser;
                          // if (user == null) {
                          //   // handle the case when no user is signed in
                          //   return;
                          // }
                          // final product = widget.product;
                          // final cartService = CartService();
                          // if (product != null) {
                          //   await cartService.removeProductCart(user.uid, cartItems[index].productId.toString());
                          // }

                          // show a snackbar
                          // showSnackBar(context, index, cartItems[index], cartItems[index].name);
                          //
                          // setState(() {
                          //   cartItems.removeAt(index);
                          //   print('cart length after deletion=> ${cartItems.length}');
                          // });
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
                                                    image: NetworkImage('${cartModel.image}'), fit: BoxFit.cover)),
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
                                                              Padding(
                                                                padding: const EdgeInsets.only(right:12.0),
                                                                child: InkWell(
                                                                  onTap: () {},
                                                                  child: Text(
                                                                    '${cartModel.price}',
                                                                    style: const TextStyle(
                                                                        fontSize: 15,
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600),
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
                                                '${cartModel.name}',
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
                                    SizedBox(width: 12,),
                                    Container(
                                      // color: Colors.blue,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Quantity is:',style: TextStyle(fontSize: 17),),
                                          // SizedBox(width: 8,),
                                          Text('${cartModel.quantity}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
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
                    }),
              ],
            ),
          ),
        );
      }
    );
  }

  // Widget CartList(){
  //   return MasonryGridView.count(
  //       physics: BouncingScrollPhysics(),
  //       crossAxisCount: 1,
  //       crossAxisSpacing: 1,
  //       mainAxisSpacing: 5,
  //       primary: false,
  //       shrinkWrap: true,
  //       itemCount:cartItems.length,
  //       itemBuilder: (context, index){
  //         if (index >= cartItems.length) {
  //           return SizedBox
  //               .shrink(); // Return an empty widget if index is out of bounds
  //         }
  //         return CartItems(context, index);
  //   });
  // }
  //
  // Widget CartItems(context, index){
  //   return Dismissible(
  //     key: Key(cartItems[index].productId.toString()),
  //     onDismissed: (direction) async {
  //       final user = FirebaseAuth.instance.currentUser;
  //       if (user == null) {
  //         // handle the case when no user is signed in
  //         return;
  //       }
  //       final product = widget.product;
  //       final cartService = CartService();
  //       if (product != null) {
  //         await cartService.removeProductCart(user.uid, cartItems[index].productId.toString());
  //       }
  //
  //       // show a snackbar
  //       showSnackBar(context, index, cartItems[index], cartItems[index].name);
  //
  //       setState(() {
  //         cartItems.removeAt(index);
  //         print('cart length after deletion=> ${cartItems.length}');
  //       });
  //     },
  //     background: deleteCartItem(),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           color: Colors.grey.shade300,
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.only(left: 10,right: 10),
  //           child: SingleChildScrollView(
  //             scrollDirection: Axis.horizontal,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                   width: 275,
  //                   child: FlipCard(
  //                     fill: Fill.fillFront,
  //                     // Fill the back side of the card to make in the same size as the front.
  //                     direction: FlipDirection.HORIZONTAL,
  //                     // default
  //                     side: CardSide.FRONT,
  //                     // The side to initially display.
  //                     front: Card(
  //                       elevation: 3,
  //                       shape: RoundedRectangleBorder(
  //                         side: BorderSide(
  //                           color: Colors.grey,
  //                         ),
  //                         borderRadius: const BorderRadius.all(Radius.circular(6)),
  //                       ),
  //                       child: Container(
  //                         // height: 10,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(6.0),
  //                             image: DecorationImage(
  //                                 image: NetworkImage('${cartItems[index].image}'), fit: BoxFit.cover)),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             ClipRRect(
  //                               borderRadius: BorderRadius.circular(6.0),
  //                               child: BackdropFilter(
  //                                 filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
  //                                 child: Container(
  //                                     height: 36,
  //                                     width: double.infinity,
  //                                     decoration: BoxDecoration(
  //                                         color: Colors.black.withOpacity(0.3)),
  //                                     child: Padding(
  //                                       padding:
  //                                       const EdgeInsets.only(left: 10, bottom: 3),
  //                                       child: Row(
  //                                         mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                         children: [
  //                                           Padding(
  //                                             padding: const EdgeInsets.only(left: 5),
  //                                             child: InkWell(
  //                                               onTap: () {},
  //                                               child: Icon(Icons.favorite_border_outlined,color: Colors.red,),
  //                                             ),
  //                                           ),
  //                                           Padding(
  //                                             padding: const EdgeInsets.only(right:12.0),
  //                                             child: InkWell(
  //                                               onTap: () {},
  //                                               child: Text(
  //                                                 '${cartItems[index].price}',
  //                                                 style: const TextStyle(
  //                                                   fontSize: 15,
  //                                                     color: Colors.white,
  //                                                     fontWeight: FontWeight.w600),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     )),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     back: Card(
  //                       color: Colors.transparent,
  //                       elevation: 0,
  //                       child: Container(
  //                         height: 120,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           color: Colors.grey,
  //                         ),
  //                         child: Center(
  //                           child: Text(
  //                             '${cartItems[index].name}',
  //                             style: TextStyle(
  //                               fontSize: 22,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: 15,),
  //                 Container(
  //                   // color: Colors.blue,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Container(
  //                         height: 30,
  //                         width: 30,
  //                         child: FloatingActionButton(
  //                           heroTag: '+',
  //                           onPressed: (){
  //                             setState(() {
  //                               counter++;
  //                               // controleQuantity(1);
  //                               print(counter);
  //                             });
  //                           },
  //                           mini: true,
  //                           backgroundColor: Color(0xFF17299F),
  //                           child: Icon(Icons.add,color: Colors.white,size: 20,),
  //                         ),
  //                       ),
  //                       SizedBox(width: 8,),
  //                       Text('$counter'),
  //                       SizedBox(width: 8,),
  //                       Container(
  //                         height: 30,
  //                         width: 30,
  //                         child: FloatingActionButton(
  //                           heroTag: '-',
  //                           onPressed: (){
  //                             setState(() {
  //                               // if (counter<=0){
  //                               //   counter=0;
  //                               //   print(counter);
  //                               // }
  //                               // else{
  //                               //   controleQuantity(-1);
  //                               //   print(counter);
  //                               // }
  //                               counter--;
  //                               // controleQuantity(1);
  //                               print(counter);
  //                               }
  //                             );
  //                           },
  //                           mini: true,
  //                           backgroundColor: Color(0xFF17299F),
  //                           child: FaIcon(
  //                             FontAwesomeIcons.minus,
  //                             color: Colors.white,
  //                             size: 20,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  showSnackBar(context,index,cartItem, name){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Your product ${name} has been deleted successfully',
            ),
          action: SnackBarAction(label: 'UNDO', onPressed: (){
            undoProduct(index, cartItem);
          }),
        ),
    );
  }

  undoProduct(index,cartItem){
    setState(() {
      cartItems.insert(index, cartItem);
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