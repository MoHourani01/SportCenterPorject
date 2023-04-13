// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sport_center_project/models/product_model.dart';
//
// class ProductService {
//   static Future<void> addProducts(List<ProductsModel> products) async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference productsCollection = firestore.collection('products');
//
//     // Query Firestore for all products
//     QuerySnapshot snapshot = await productsCollection.get();
//
//     // Extract the names of all existing products from the snapshot
//     List<String> existingProductNames = snapshot.docs.map((doc) => doc['name'] as String).toList();
//
//     // Add only new products to Firestore
//     for (ProductsModel product in products) {
//       if (!existingProductNames.contains(product.name)) {
//         await productsCollection.add(product.toProductMap());
//       }
//     }
//   }
// }
//
//

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_center_project/models/product_model.dart';

class ProductService {
  static Future<void> addProducts(List<ProductsModel> products) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('products');

    // Query Firestore for all products
    QuerySnapshot snapshot = await productsCollection.get();

    // Extract the names of all existing products from the snapshot
    List<String> existingProductNames = snapshot.docs.map((doc) => doc['name'] as String).toList();

    // Add only new products to Firestore
    for (ProductsModel product in products) {
      if (!existingProductNames.contains(product.name)) {
        DocumentReference docRef = await productsCollection.add(product.toProductMap());
        await docRef.update({'productId': docRef.id});
      }
    }
  }
  static Future<void> addSoccerProducts(List<ProductsModel> products) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('soccer_products');

    // Query Firestore for all products
    QuerySnapshot snapshot = await productsCollection.get();

    // Extract the names of all existing products from the snapshot
    List<String> existingProductNames = snapshot.docs.map((doc) => doc['name'] as String).toList();

    // Add only new products to Firestore
    for (ProductsModel product in products) {
      if (!existingProductNames.contains(product.name)) {
        DocumentReference docRef = await productsCollection.add(product.toProductMap());
        await docRef.update({'productId': docRef.id});
      }
    }
  }
  static Future<void> addBasketballProducts(List<ProductsModel> products) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('basketball_products');

    // Query Firestore for all products
    QuerySnapshot snapshot = await productsCollection.get();

    // Extract the names of all existing products from the snapshot
    List<String> existingProductNames = snapshot.docs.map((doc) => doc['name'] as String).toList();

    // Add only new products to Firestore
    for (ProductsModel product in products) {
      if (!existingProductNames.contains(product.name)) {
        DocumentReference docRef = await productsCollection.add(product.toProductMap());
        await docRef.update({'productId': docRef.id});
      }
    }
  }

  Future<void> add_Products(ProductsModel model, String collection) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection(collection)
        .add(model.toProductMap())
        .whenComplete(() {
      log('posts data added successful');
      // statusCode = 200;
      msg = 'posts data added successful';
    }).catchError((onError) {
      handleAuthErrors(onError);
      log('statusCode : $statusCode , error msg : $msg');
    });
  }
  int statusCode = 0;
  String msg = '';
  void handleAuthErrors(ArgumentError error) {
    String errorCode = error.message;
    switch (errorCode) {
      case "ABORTED":
        {
          statusCode = 400;
          msg = "The operation was aborted";
        }
        break;
      case "ALREADY_EXISTS":
        {
          statusCode = 400;
          msg = "Some document that we attempted to create already exists.";
        }
        break;
      case "CANCELLED":
        {
          statusCode = 400;
          msg = "The operation was cancelled";
        }
        break;
      case "DATA_LOSS":
        {
          statusCode = 400;
          msg = "Unrecoverable data loss or corruption.";
        }
        break;
      case "PERMISSION_DENIED":
        {
          statusCode = 400;
          msg =
          "The caller does not have permission to execute the specified operation.";
        }
        break;
      default:
        {
          statusCode = 400;
          msg = error.message;
        }
        break;
    }
  }

}
