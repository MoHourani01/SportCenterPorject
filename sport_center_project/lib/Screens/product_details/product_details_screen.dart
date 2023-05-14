import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/Screens/basketball/basketball_layout/basketball_screen.dart';
import 'package:sport_center_project/Screens/cart/Cart_Screen.dart';
import 'package:sport_center_project/Screens/cart/cart_service/cart_service.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/soccer/soccer_layout/soccer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDetail extends StatefulWidget {
  final ProductsModel product;
  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();

}

class _ProductDetailState extends State<ProductDetail> {

  final CartService cartService = CartService();

  int activatedIndex = 0;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  int counter=0;

  void controleQuantity(int quantity) async {
    final updatedQuantity = counter + quantity;
    await cartService.updateCart(widget.product, updatedQuantity);
    setState(() {
      counter = updatedQuantity;
    });
  }

  // Future<void> addToCart(ProductsModel product) async {
  //   // get the current user
  //   final user = FirebaseAuth.instance.currentUser;
  //
  //   if (user == null) {
  //     // handle the case when no user is signed in
  //     return;
  //   }
  //
  //   // add the product to the cart
  //   await CartService().updateCart(product, counter);
  //
  //
  // }
  Future<void> addToCart(ProductsModel product) async {
    // CartService.instance.cartItems.add(product);
    // get the current user
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // handle the case when no user is signed in
      return;
    }

    // add the product to the cart
    await CartService().addToCart(user.uid, product, 1);
    await CartService().updateCart(product, counter);
  }

  @override
  void initState() {
    super.initState();
    _getProductQuantityFromCart();
  }

  void _getProductQuantityFromCart() async {
    final quantity = await cartService.getProductQuantityFromCart(widget.product.productId!);
    setState(() {
      counter = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffb2adca).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10.0,
                      offset: -Offset(0, 3),
                    )
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${widget.product.image}'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          navigators.navigatePop(context);
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color:  Color(0xF717217A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.product.name}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "${widget.product.price}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff39393b),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Price Incluslve of all Texes",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 6,),
                    Text(
                      "Choose Size",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i=0; i<sizes.length; i++)
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      activatedIndex=i;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: activatedIndex == i
                                            ?  Color(0xF717217A)
                                            : Colors.white70,
                                        borderRadius: BorderRadius.circular(6)),
                                    child:Text(
                                      sizes[i],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: sizes[i] == sizes[activatedIndex]
                                            ? Colors.white
                                            : Colors.blueGrey.shade900
                                            .withOpacity(1),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 15,
                        //       backgroundColor: Color(0xff317aaf),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Divider(
                                  thickness: 3.5,
                                  color:Color(0xFF130359),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.product.description}",maxLines: 3,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              if (CartService.instance.cartItems.any((item) => item.productId == widget.product.productId)){
                                print('exists=> ${CartService.instance.cartItems.length}');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.grey.shade800,
                                  content: Text('Product has already added into cart list'),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    textColor: Colors.white,
                                    label: 'View',
                                    onPressed: () {
                                      navigators.navigatorWithBack(context, CartScreen());
                                    },
                                  ),
                                ));
                              }else{
                                addToCart(widget.product);
                                print('added=> ${CartService.instance.cartItems.length}');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.grey.shade800,
                                  content: Text('Product added to cart'),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    textColor: Colors.white,
                                    label: 'View',
                                    onPressed: () {
                                      navigators.navigatorWithBack(context, CartScreen());
                                    },
                                  ),
                                ));
                              }
                            },
                            height: 66,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                              height: 66,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF1D2EA8),
                                    Color(0xFF130359),
                                    Color(0xF717217A),
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: FloatingActionButton(
                                heroTag: 'plus',
                                onPressed: (){
                                  controleQuantity(1);
                                  print(counter);
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
                                heroTag: 'minus',
                                onPressed: (){

                                    if (counter<=0){
                                      counter=0;
                                      print(counter);
                                    }
                                    else{
                                      controleQuantity(-1);
                                      print(counter);
                                    }

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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}