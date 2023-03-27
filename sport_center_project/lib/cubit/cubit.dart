import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_center_project/Screens/cart/Cart_Screen.dart';
import 'package:sport_center_project/Screens/favorite/favorite_screen.dart';
import 'package:sport_center_project/models/product_model.dart';

import 'package:sport_center_project/Screens/home/home_screen.dart';
import 'package:sport_center_project/Screens/news/news_screen.dart';
import 'package:sport_center_project/cubit/states.dart';
import 'package:sport_center_project/models/login_model.dart';
import 'package:sport_center_project/shared/component/constants.dart';

class SportCenterCubit extends Cubit<SportCenterStates> {
  SportCenterCubit() : super(SportCenterInitiaState());

  static SportCenterCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  int currentIndex = 0;

  void userData() {
    emit(SportCenterGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(SportCenterGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SportCenterGetUserErrorState(error.toString()));
    });
  }


  List<UserModel> users = [];

  void getUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.id != uId)
          users.add(UserModel.fromJson(element.data()));
        print(users);
      });
      emit(SportCenterGetUserSuccessState());
    }).catchError((error) {
      emit(SportCenterGetUserErrorState(error.toString()));
    });
  }

  ProductsModel? productModel;

  Future<void> productCubit({
    String? name,
    String? price,
    String? image,
    String? productId,
    String? description,
  }) async{
    // emit(SocialCreatePostLoadingState());

    ProductsModel model = ProductsModel(
      name: productModel!.name,
      image: image ?? '',
      productId: productModel!.productId,
      price: productModel!.price,
      description: productModel!.description??'',
      // postImage: image ?? '',
    );

    await FirebaseFirestore.instance
        .collection('products')
        .add(model.toProductMap())
        .then((value) {
      emit(SportCenterProductSuccessState());
    }).catchError((error) {
      // emit(SportCenterProductErrorState());
    });
  }


  List<ProductsModel> products=[
    ProductsModel(
      name: 'Man United Jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0002/6440/5057/products/Home1OG.jpg',
    ),
    ProductsModel(
      name: 'Barcelona Jersey',
      price: '50 JD',
      image: 'https://arenajerseys.com/wp-content/uploads/2022/06/download-4.jpg',
    ),
    ProductsModel(
      name: 'RealMadrid Jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0405/9807/7603/products/HF0291-RMCFMZ0074-02_500x480.jpg?v=1655974763',
    ),
    ProductsModel(
      name: 'Miami Heat Jersey',
      price: '60 JD',
      image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/fddec8b1-7aee-4b47-826d-f2ec00ad4e66/miami-heat-association-edition-2022-23-dri-fit-nba-swingman-jersey-gLpkQ8.png',
    ),
  ];

  List<String> productID = [];

  void addProductsToFirebase(List<ProductsModel> products) {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    CollectionReference productsRef = FirebaseFirestore.instance.collection('products');

    for (ProductsModel product in products) {
      DocumentReference newProductRef = productsRef.doc();
      batch.set(newProductRef, product.toProductMap());
      // Update the productId field of the added document with the generated document ID
      batch.update(newProductRef, {'productId': newProductRef.id});
    }

    batch.commit().then((value) {
      print('All products added successfully!');
    }).catchError((error) {
      print('Error adding products: $error');
    });
  }

//=============================================================

}
