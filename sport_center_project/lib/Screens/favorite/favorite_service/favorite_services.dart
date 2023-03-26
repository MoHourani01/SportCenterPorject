import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/models/product_model.dart';

class FirestoreService {
  final CollectionReference _favoritesCollectionReference =
  FirebaseFirestore.instance.collection('favorites');

  Future<void> addToFavorites(ProductsModel product) async {
    await _favoritesCollectionReference.doc(product.productId).set(product.toProductMap());
  }

  Future<void> removeFromFavorites(ProductsModel product) async {
    try {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(product.productId)
          .delete();
    } catch (e) {
      print('Error removing product from favorites: $e');
      rethrow;
    }
  }

  // Future<void> toggleFavoriteStatus(ProductsModel product) async {
  //   product.isFavorite = !product.isFavorite;
  //   if (product.isFavorite) {
  //     await addToFavorites(product);
  //   } else {
  //     final snapshot = await _favoritesCollectionReference.where('productId', isEqualTo: product.productId).get();
  //     snapshot.docs.forEach((doc) => doc.reference.delete());
  //   }
  // }

}
