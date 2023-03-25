import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_center_project/models/product_model.dart';

class FirestoreService {
  final CollectionReference _favoritesCollectionReference =
  FirebaseFirestore.instance.collection('favorites');

  Future<void> addToFavorites(ProductsModel product) async {
    await _favoritesCollectionReference.doc(product.productId).set(product.toProductMap());
  }
}
