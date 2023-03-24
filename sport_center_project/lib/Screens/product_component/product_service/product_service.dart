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
}
