// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sport_center_project/models/product_model.dart';
// import 'package:sport_center_project/shared/component/component.dart';
// class FavoriteService {
//   final _firebaseAuth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//
//   Future<void> toggleFavorite(ProductsModel product) async {
//     if (product.productId == null) {
//       return;
//     }
//
//     // get the current user
//     final user = _firebaseAuth.currentUser;
//
//     if (user == null) {
//       // handle the case when no user is signed in
//       print('User is null');
//     }
//
//     // get the user document
//     final userDoc = _firestore.collection('users').doc(user!.uid);
//
//     // check if the product is already in favorites
//     final doc = await userDoc.collection('favorites').doc(product.productId).get();
//     bool isFavorite = doc.exists;
//     // showToast(text: 'Product ${product.name} is already in favorite', state: ToastStates.Warning);
//
//     // toggle the isFavorite flag
//     isFavorite = !isFavorite;
//
//     // update the favorites collection
//     if (isFavorite) {
//       // if the product is not in favorites, add it
//       await userDoc.collection('favorites').doc(product.productId).set(product.toProductMap());
//       showToast(text: 'Product ${product.name} added to favorite', state: ToastStates.Success);
//     } else {
//       // if the product is already in favorites, remove it
//       await userDoc.collection('favorites').doc(product.productId).delete();
//       showToast(text: 'Product ${product.name} deleted from favorite', state: ToastStates.Error);
//     }
//   }
//
//   Stream<bool> isFavoriteStream(String productId) {
//     // get the current user
//     final user = _firebaseAuth.currentUser;
//
//     if (user == null) {
//       // handle the case when no user is signed in
//       return Stream.value(false);
//     }
//
//     // get the user document
//     final userDoc = _firestore.collection('users').doc(user.uid);
//
//     // return a stream of whether the product is in favorites
//     return userDoc
//         .collection('favorites')
//         .doc(productId)
//         .snapshots()
//         .map((doc) => doc.exists);
//   }
//
//   Stream<List<ProductsModel>> favoritesStream() {
//     // get the current user
//     final user = _firebaseAuth.currentUser;
//
//     if (user == null) {
//       // handle the case when no user is signed in
//       return Stream.value([]);
//     }
//
//     // get the user document
//     final userDoc = _firestore.collection('users').doc(user.uid);
//
//     // return a stream of the user's favorite products
//     return userDoc.collection('favorites').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => ProductsModel.fromFirestore(doc)).toList();
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';

class FavoriteService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> toggleFavorite(ProductsModel product) async {
    if (product.productId == null) {
      return;
    }

    // get the current user
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      // handle the case when no user is signed in
      return;
    }

    // get the user document and the favorites subcollection
    final userDoc = _firestore.collection('users').doc(user.uid);
    final favoritesCollection = userDoc.collection('favorites');

    // check if the product is already in favorites
    final doc = await favoritesCollection.doc(product.productId).get();
    bool isFavorite = doc.exists;

    // toggle the isFavorite flag
    isFavorite = !isFavorite;

    // update the favorites collection
    if (isFavorite) {
      // if the product is not in favorites, add it
      await favoritesCollection.doc(product.productId).set({'productId': product.toProductMap(), 'userId': user.uid});
      showToast(text: 'Product ${product.name} added to favorite', state: ToastStates.Success);
    } else {
      // if the product is already in favorites, remove it
      await favoritesCollection.doc(product.productId).delete();
      showToast(text: 'Product ${product.name} deleted from favorite', state: ToastStates.Error);
    }
  }

  Stream<List<String>> getFavoriteProductIds() {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      // handle the case when no user is signed in
      return Stream.empty();
    }

    // get the favorites subcollection for the current user
    final userDoc = _firestore.collection('users').doc(user.uid);
    final favoritesCollection = userDoc.collection('favorites');

    // query the favorites subcollection for productIds
    return favoritesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()['productId'].toString()).toList();
    });
  }
}

