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
  final firestore = FirebaseFirestore.instance;

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

  // Future<void> add_Products(ProductsModel model, String collection) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   await firestore
  //       .collection(collection)
  //       .add(model.toProductMap())
  //       .whenComplete(() {
  //     log('posts data added successful');
  //     // statusCode = 200;
  //     msg = 'posts data added successful';
  //   }).catchError((onError) {
  //     handleAuthErrors(onError);
  //     log('statusCode : $statusCode , error msg : $msg');
  //   });
  // }
  Future<void> addProduct(ProductsModel product) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('products').doc(product.productId).set(product.toProductMap())
        .whenComplete(() {
      log('Product added successfully');
    }).catchError((onError) {
      handleAuthErrors(onError);
      log('Error adding product: $onError');
    });
  }
  // Stream<ProductsList> getPosts(String collection) {
  //   return FirebaseFirestore.instance
  //       .collection(collection)
  //       .snapshots()
  //       .map((snapshot) => ProductsList.fromJson(snapshot.docs.map((doc) => doc.data()).toList()));
  // }
  Stream<ProductsList> getPosts(String collection) {
    return FirebaseFirestore.instance
        .collection(collection)
        .snapshots()
        .map((snapshot) {
      List<ProductsModel> products = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ProductsModel.fromJson(data);
      }).toList();

      return ProductsList(posts: products);
    })
        .handleError((error) {
      // Handle any errors that occur during the stream processing
      print('Error retrieving products: $error');
    });
  }
  CollectionReference _collection = FirebaseFirestore.instance.collection('products');
  Future<ProductsModel> getUser(String id) async {
    QuerySnapshot result = await _collection.where('productId', isEqualTo: id).get();
    var data = result.docs[0];
    Map<String, dynamic> userMap = {};
    userMap['productId'] = data.get('productId');
    userMap['name'] = data.get('name');
    userMap['price'] = data.get('price');
    userMap['image'] = data.get('image');
    userMap['description'] = data.get('description');

    var userModel = ProductsModel.fromJson(userMap);
    return userModel;
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
