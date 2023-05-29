import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/Utilities/VariablesUtils.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text('Reports'),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('reports').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final reportData = snapshot.data!.docs;
                  final cartProducts = <ProductsModel>[];
                  final favoriteProducts = <ProductsModel>[];

                  for (final doc in reportData) {
                    final data = doc.data() as Map<String, dynamic>;
                    final product = ProductsModel.fromJson(data);
                    final source = data['source'];
                    var date = data['addedTime'] as Timestamp;
                    final addedTime = date.toDate();
                    print(addedTime);
                    if (source == 'cart') {
                      cartProducts.add(product);
                    } else if (source == 'favorites') {
                      favoriteProducts.add(product);
                    }
                  }

                  return Column(
                    children: [
                      Text(
                        'Cart Products:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final doc = reportData[index];
                          final data = doc.data() as Map<String, dynamic>;
                          var date = data['addedTime'] as Timestamp;
                          final addedTime = date.toDate();
                          final product = cartProducts[index];
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              height: 125,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'User: ${VariablesUtils.userName} -- UserID: ${VariablesUtils.uid}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      product.name ?? '',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Price: ${product.price ?? ''} - Quantity: ${product.quantity ?? 0}'),
                                    Expanded(child: Text('Added Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(addedTime)}')),
                                  ],
                                  // title: Text(product.name ?? ''),
                                  // subtitle: Text('Price: ${product.price ?? ''} - Quantity: ${product.quantity ?? 0}'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Favorite Products:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final doc = reportData[index];
                          final data = doc.data() as Map<String, dynamic>;
                          // final product = ProductsModel.fromJson(data);
                          var date = data['addedTime'] as Timestamp;
                          final addedTime = date.toDate();
                          final product = favoriteProducts[index];
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                height: 125,
                                  decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'User: ${VariablesUtils.userName} -- UserID: ${VariablesUtils.uid}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                        product.name ?? '',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Expanded(child: Text('Price: ${product.price ?? ''} -- Description: ${product.description ?? ''}')),
                                    Expanded(child: Text('Added Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(addedTime)}'),
                                    ),
                                  ],
                                  // title: Text(product.name ?? ''),
                                  // subtitle: Text('Price: ${product.price ?? ''} - Quantity: ${product.quantity ?? 0}'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Favorite Report',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartData.length,
                      itemBuilder: (context, index) {
                        var cartModel = ProductsModel(
                            name: data[index].get('name'),
                            price: data[index].get('price'),
                            // productId: data[index].get('productId'),
                            quantity: data[index].get('quantity')
                        );
                        final cartDoc = cartData[index];
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'User: ${VariablesUtils.userName} -- UserID: ${VariablesUtils.uid}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'ProductName: ${cartModel.name} -- '
                                        'ProductPrice: ${cartModel.price} -- '
                                        'ProductQuanityt: ${cartModel.quantity}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
 */
/*
return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('favorites')
                .snapshots(),
              builder: (context, favoritesSnapshot){
                if (!favoritesSnapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final favoritesData = favoritesSnapshot.data!.docs;


              }
          );
 */
/*
return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cart Report',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartData.length,
                        itemBuilder: (context, index) {
                          var cartModel = ProductsModel(
                              name: data[index].get('name'),
                              price: data[index].get('price'),
                              // productId: data[index].get('productId'),
                              quantity: data[index].get('quantity')
                          );
                          final cartDoc = cartData[index];
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User: ${VariablesUtils.userName} -- UserID: ${VariablesUtils.uid}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      'ProductName: ${cartModel.name} -- '
                                          'ProductPrice: ${cartModel.price} -- '
                                          'ProductQuanityt: ${cartModel.quantity}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Favorite Report',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartData.length,
                        itemBuilder: (context, index) {
                          var cartModel = ProductsModel(
                              name: data[index].get('name'),
                              price: data[index].get('price'),
                              // productId: data[index].get('productId'),
                              quantity: data[index].get('quantity')
                          );
                          final cartDoc = cartData[index];
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User: ${VariablesUtils.userName} -- UserID: ${VariablesUtils.uid}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      'ProductName: ${cartModel.name} -- '
                                          'ProductPrice: ${cartModel.price} -- '
                                          'ProductQuanityt: ${cartModel.quantity}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
 */
/*
AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Reports',
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
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
      )
 */


/*
StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('reports').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final reportData = snapshot.data!.docs;
                  final cartProducts = <ProductsModel>[];
                  final favoriteProducts = <ProductsModel>[];

                  return Column(
                    children: [
                      Text(
                        'Cart Products:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: reportData.length,
                        itemBuilder: (context, index) {
                          final doc = reportData[index];
                          final data = doc.data() as Map<String, dynamic>;
                          final product = ProductsModel.fromJson(data);
                          final source = data['source'];
                          var date = data['addedTime'] as Timestamp;
                          final addedTime = date.toDate();

                          if (source == 'cart') {
                            cartProducts.add(product);
                            return ListTile(
                              title: Text(product.name ?? ''),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price: ${product.price ?? ''}'),
                                  Text('Quantity: ${product.quantity ?? 0}'),
                                  Text('Added Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(addedTime)}'),
                                ],
                              ),
                            );
                          } else if (source == 'favorites') {
                            favoriteProducts.add(product);
                          }

                          return SizedBox.shrink(); // Placeholder return statement if source is neither 'cart' nor 'favorite'
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Favorite Products:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final doc = reportData[index];
                          final data = doc.data() as Map<String, dynamic>;
                          final product = favoriteProducts[index];
                          var date = data['addedTime'] as Timestamp;
                          final addedTime = date.toDate();
                          return ListTile(
                            title: Text(product.name ?? ''),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: ${product.price ?? ''}'),
                                Text('Quantity: ${product.quantity ?? 0}'),
                                Text('Added Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(addedTime)}'),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              )
 */


/*
Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text('Reports'),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cart Report',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .collection('cart')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final cartDocs = snapshot.data!.docs;
                if (cartDocs.isEmpty) {
                  return Text('No products in cart');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartDocs.length,
                  itemBuilder: (context, index) {
                    final cartDoc = cartDocs[index];
                    final cartData = cartDoc.data() as Map<String, dynamic>;
                    final cartModel = ProductsModel(
                      name: cartData['name'] ?? '',
                      price: cartData['price'] ?? '',
                      quantity: cartData['quantity'] ?? '',
                    );

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User: ${VariablesUtils.userName} -- UserID: ${VariablesUtils.uid}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'ProductName: ${cartModel.name} -- '
                                    'ProductPrice: ${cartModel.price} -- '
                                    'ProductQuantity: ${cartModel.quantity}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Favorite Report',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('favorites')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final favoriteDocs = snapshot.data!.docs;

                if (favoriteDocs.isEmpty) {
                  return Text('No favorite products');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: favoriteDocs.length,
                  itemBuilder: (context, index) {
                    final favoriteDoc = favoriteDocs[index];
                    final favoriteData = favoriteDoc.data() as Map<String, dynamic>;
                    final favoriteModel = ProductsModel(
                      name: favoriteData['name'] ?? '',
                      price: favoriteData['price'] ?? '',
                      quantity: favoriteData['quantity'] ?? 0,
                    );

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User: ${VariablesUtils.userName} -- UserID: ${VariablesUtils.uid}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'ProductName: ${favoriteModel.name} -- '
                                    'ProductPrice: ${favoriteModel.price} -- '
                                    'ProductQuantity: ${favoriteModel.quantity}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    )
 */