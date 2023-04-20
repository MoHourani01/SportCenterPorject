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
        'productId': product.toProductMap(),
        'userId': user.uid,
        'quantity': quantity
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

  // Future<void> addToCart(String userId, ProductsModel product, int quantity) async {
  //   final cartRef = firestore.collection('users').doc(userId).collection('cart');
  //   final productRef = cartRef.doc(product.productId);
  //
  //   final data = {
  //     'name': product.name,
  //     'price': product.price,
  //     'quantity': quantity,
  //     'image': product.image,
  //     'productId': product.productId,
  //   };
  //
  //   await productRef.set(data, SetOptions(merge: true));
  // }

  List<ProductsModel> cartItems = [];

  static final CartService instance = CartService._internal();

  factory CartService() {
    return instance;
  }

  CartService._internal();

  List<ProductsModel> get cartItem => cartItems;

  // void addToCart(ProductsModel product) {
  // }
  Future<void> addToCart(String userId, ProductsModel product, int quantity) async {
    cartItems.add(product);
    final cartRef = firestore.collection('users').doc(userId).collection('cart');
    final productRef = cartRef.doc(product.productId);

    final data = {
      'name': product.name,
      'price': product.price,
      'quantity': quantity,
      'image': product.image,
      'productId': product.productId,
    };

    await productRef.set(data, SetOptions(merge: true));
  }

  void removeFromCart(ProductsModel product) {
    cartItems.remove(product);
  }

  void clearCart() {
    cartItems.clear();
  }

  Future<void> removeProductCart(String userId, String productId) async {
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId);
    await docRef.delete();
  }
}
