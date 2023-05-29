import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';

class CartService {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> updateCart(ProductsModel product, int quantity) async {
    if (product.productId == null) {
      return;
    }

    final user = firebaseAuth.currentUser;

    if (user == null) {
      return;
    }

    final userDoc = firestore.collection('users').doc(user.uid);
    final cartCollection = userDoc.collection('cart');

    final doc = await cartCollection.doc(product.productId).get();
    bool isExist = doc.exists;

    if (quantity <= 0) {
      if (isExist) {
        await cartCollection.doc(product.productId).delete();
      }
      return;
    }

    if (isExist) {
      await cartCollection.doc(product.productId).update({'quantity': quantity});
    } else {
      await cartCollection.doc(product.productId).set({
        // 'productId': product.toProductMap(),
        ...product.toProductMap(),
        'userId': user.uid,
        'quantity': quantity,
      });
    }
  }

  Future<int> getProductQuantityFromCart(String productId) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return 0;
    }
    final userDoc = firestore.collection('users').doc(user.uid);
    final cartCollection = userDoc.collection('cart');
    final doc = await cartCollection.doc(productId).get();
    if (doc.exists) {
      return doc.data()!['quantity'] ?? 0;
    } else {
      return 0;
    }
  }

  List<ProductsModel> cartItems = [];

  static final CartService instance = CartService._internal();

  factory CartService() {
    return instance;
  }

  CartService._internal();

  // List<ProductsModel> get cartItem => cartItems;

  // void addToCart(ProductsModel product) {
  // }
  // Future<void> addToCart(String userId, ProductsModel product, int quantity) async {
  //   cartItems.add(product);
  //   final cartRef = firestore.collection('users').doc(userId).collection('cart');
  //   final productRef = cartRef.doc(product.productId);
  //
  //   // final data = {
  //   //   'name': product.name,
  //   //   'price': product.price,
  //   //   'quantity': quantity,
  //   //   'image': product.image,
  //   //   'productId': product.productId,
  //   // };
  //
  //   // await productRef.set(data, SetOptions(merge: true));
  //   await CartService().updateCart(product, quantity);
  //   print('cart after adding=> ${cartItems}');
  //   print('cart length after adding=> ${cartItems.length}');
  // }
  // Future<void> addToCart(String userId, ProductsModel product, int quantity) async {
  //   // Check if the product already exists in the cartItems list
  //   bool productExists = cartItems.any((item) => item.productId == product.productId);
  //   if (productExists) {
  //     return;
  //   }
  //
  //   cartItems.add(product);
  //   final cartRef = firestore.collection('users').doc(userId).collection('cart');
  //   final productRef = cartRef.doc(product.productId);
  //   await CartService().updateCart(product, quantity);
  //   print('cart after adding=> ${product.name}');
  //   print('cart after adding=> ${cartItems}');
  //   print('cart length after adding=> ${cartItems.length}');
  // }
  Future<void> addToCart(String userId, ProductsModel product, int quantity) async {
    // Check if the product already exists in the cart
    final userDoc = firestore.collection('users').doc(userId);
    final cartCollection = userDoc.collection('cart');
    final doc = await cartCollection.doc(product.productId).get();

    if (doc.exists) {
      // If the product already exists, update its quantity
      final int currentQuantity = doc.data()!['quantity'];
      await cartCollection.doc(product.productId).update({'quantity': currentQuantity + quantity});
    } else {
      // If the product doesn't exist, add it to the cart
      await cartCollection.doc(product.productId).set({
        ...product.toProductMap(),
        'userId': userId,
        'quantity': quantity,
      });
    }

    // Update the cartItems list to reflect the changes in the database
    final cartData = await cartCollection.get();
    final cartItemsList = ProductsList.fromJson(cartData.docs.map((e) => e.data()).toList());
    final cartItems = cartItemsList.posts;
    final reportDocRef = FirebaseFirestore.instance.collection('reports').doc(product.productId);
    await reportDocRef.set({
      ...product.toProductMap(),
      'userId': userId,
      'quantity': quantity,
      'addedTime': DateTime.now(),
      'source': 'cart',
    });
  }

  static Future<ProductsList> getProducts() async {
    final List<ProductsModel> products = [];
    final CollectionReference collection =
    FirebaseFirestore.instance.collection('products');
    final QuerySnapshot querySnapshot = await collection.get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;

    final List<Future<ProductsModel>> futures = documents.map((doc) async {
      final productId = doc.id;
      final quantity = await CartService.instance.getProductQuantityFromCart(productId);


      return ProductsModel(
        productId: productId,
        name: doc['name'],
        price: doc['price'],
        image: doc['image'],
        description: doc['description'],
        quantity: quantity,
      );
    }).toList();

    final List<ProductsModel> productsData = await Future.wait(futures);
    products.addAll(productsData);

    return ProductsList(posts: products);
  }

  // void removeFromCart(ProductsModel product) {
  //   cartItems.remove(product);
  //   print('cart after deleting=> ${product.name}');
  //   print('cart after deleting=> ${cartItems}');
  //   print('cart length after deleting=> ${cartItems.length}');
  // }
  Future<void> removeFromCart(ProductsModel product) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return;
    }

    final cartData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .where('productId', isEqualTo: product.productId)
        .get();

    if (cartData.size > 0) {
      final cartItemId = cartData.docs.first.id;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(cartItemId)
          .delete();
    }
  }



  void clearCart() {
    cartItems.clear();
  }
}
