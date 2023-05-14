// import 'package:cloudfirestore/cloudfirestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sport_center_project/models/product_model.dart';
// import 'package:sport_center_project/shared/component/component.dart';
// class FavoriteService {
//   final firebaseAuth = FirebaseAuth.instance;
//   final firestore = FirebaseFirestore.instance;
//
//   Future<void> toggleFavorite(ProductsModel product) async {
//     if (product.productId == null) {
//       return;
//     }
//
//     // get the current user
//     final user = firebaseAuth.currentUser;
//
//     if (user == null) {
//       // handle the case when no user is signed in
//       print('User is null');
//     }
//
//     // get the user document
//     final userDoc = firestore.collection('users').doc(user!.uid);
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
//     final user = firebaseAuth.currentUser;
//
//     if (user == null) {
//       // handle the case when no user is signed in
//       return Stream.value(false);
//     }
//
//     // get the user document
//     final userDoc = firestore.collection('users').doc(user.uid);
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
//     final user = firebaseAuth.currentUser;
//
//     if (user == null) {
//       // handle the case when no user is signed in
//       return Stream.value([]);
//     }
//
//     // get the user document
//     final userDoc = firestore.collection('users').doc(user.uid);
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
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  // Future<void> toggleFavorite(ProductsModel product) async {
  //   if (product.productId == null) {
  //     return;
  //   }
  //
  //   // get the current user
  //   final user = firebaseAuth.currentUser;
  //
  //   if (user == null) {
  //     // handle the case when no user is signed in
  //     return;
  //   }
  //
  //   // get the user document and the favorites subcollection
  //   final userDoc = firestore.collection('users').doc(user.uid);
  //   final favoritesCollection = userDoc.collection('favorites');
  //
  //   // check if the product is already in favorites
  //   final doc = await favoritesCollection.doc(product.productId).get();
  //   bool isFavorite = doc.exists;
  //
  //   // toggle the isFavorite flag
  //   isFavorite = !isFavorite;
  //
  //   // update the favorites collection
  //   if (isFavorite) {
  //     // if the product is not in favorites, add it
  //     await favoritesCollection.doc(product.productId).set({'productId': product.toProductMap(), 'userId': user.uid});
  //     showToast(text: 'Product ${product.name} added to favorite', state: ToastStates.Success);
  //   } else {
  //     // if the product is already in favorites, remove it
  //     await favoritesCollection.doc(product.productId).delete();
  //     showToast(text: 'Product ${product.name} deleted from favorite', state: ToastStates.Error);
  //   }
  // }
  Stream<bool> isFavoriteStream(ProductsModel product) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not signed in
      return Stream.value(false);
    } else {
      final favoritesCollection =
      FirebaseFirestore.instance.collection('users/${user.uid}/favorites');
      return favoritesCollection
          .doc(product.productId)
          .snapshots()
          .map((snapshot) => snapshot.exists);
    }
  }

  Future<void> toggleFavorite(ProductsModel product) async {
    if (product.productId == null) {
      return;
    }

    // get the current user
    final user = firebaseAuth.currentUser;

    if (user == null) {
      // handle the case when no user is signed in
      return;
    }

    // get the user document and the favorites subcollection
    final userDoc = firestore.collection('users').doc(user.uid);
    final favoritesCollection = userDoc.collection('favorites');

    // check if the product is already in favorites
    final doc = await favoritesCollection.doc(product.productId).get();
    bool isFavorite = doc.exists;

    // toggle the isFavorite flag
    isFavorite = !isFavorite;

    // update the favorites collection
    if (isFavorite) {
      // if the product is not in favorites, add it
      await favoritesCollection.doc(product.productId).set({'Product':product.toProductMap(),'userId': user.uid});
      showToast(text: 'Product ${product.name} added to favorite', state: ToastStates.Success);
    } else {
      // if the product is already in favorites, remove it
      await favoritesCollection.doc(product.productId).delete();
      showToast(text: 'Product ${product.name} deleted from favorite', state: ToastStates.Error);
    }
  }

  Future<List<ProductsModel>> getFavorites() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();
        final List<dynamic> favoriteProductsIds = userDoc.get('favorites');
        final List<ProductsModel> favoriteProducts = [];
        for (String productId in favoriteProductsIds) {
          final DocumentSnapshot productDoc = await firestore.collection('products').doc(productId).get();
          final ProductsModel product = ProductsModel.fromJson((productDoc.data() ?? {}) as Map<String, dynamic>);
          favoriteProducts.add(product);
        }
        return favoriteProducts;
      }
      else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

// Stream<List<String>> getFavoriteProductIds() {
//   final user = firebaseAuth.currentUser;
//
//   if (user == null) {
//     // handle the case when no user is signed in
//     return Stream.empty();
//   }
//
//   // get the favorites subcollection for the current user
//   final userDoc = firestore.collection('users').doc(user.uid);
//   final favoritesCollection = userDoc.collection('favorites');
//
//   // query the favorites subcollection for productIds
//   return favoritesCollection.snapshots().map((snapshot) {
//     return snapshot.docs.map((doc) => doc.data()['productId'].toString()).toList();
//   });
// }
//
// static List<ProductsModel> favorites=[];
//
// void addFavorite(ProductsModel product) {
//   favorites.add(product);
// }
//
// void removeFavorite(ProductsModel product) {
//   favorites.remove(product);
// }
//
// static List<ProductsModel> getFavorites() {
//   return favorites;
// }
//
// Future<void> setFavorites(List<ProductsModel> favorites) async {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     CollectionReference favoritesRef = firestore.collection('favorites').doc(user.uid).collection('items');
//     WriteBatch batch = firestore.batch();
//
//     // Remove all previous favorites from Firestore
//     QuerySnapshot favoritesSnapshot = await favoritesRef.get();
//     favoritesSnapshot.docs.forEach((doc) {
//       batch.delete(doc.reference);
//     });
//
//     // Add new favorites to Firestore
//     favorites.forEach((product) {
//       batch.set(favoritesRef.doc(product.productId), product.toProductMap());
//     });
//
//     await batch.commit();
//   }
// }

}

