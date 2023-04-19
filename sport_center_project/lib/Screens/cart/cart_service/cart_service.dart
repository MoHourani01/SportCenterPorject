import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';

class CartService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> updateCart(ProductsModel product, int quantity) async {
    if (product.productId == null) {
      return;
    }

    final user = _firebaseAuth.currentUser;

    if (user == null) {
      return;
    }

    final userDoc = _firestore.collection('users').doc(user.uid);
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
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return 0;
    }
    final userDoc = _firestore.collection('users').doc(user.uid);
    final cartCollection = userDoc.collection('cart');
    final doc = await cartCollection.doc(productId).get();
    if (doc.exists) {
      return doc.data()!['quantity'] ?? 0;
    } else {
      return 0;
    }
  }

  Future<void> addToCart(String userId, ProductsModel product, int quantity) async {
    final cartRef = _firestore.collection('users').doc(userId).collection('cart');
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
}
