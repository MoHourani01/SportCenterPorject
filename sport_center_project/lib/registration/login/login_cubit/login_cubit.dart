import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_center_project/registration/UserService/user_service.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_center_project/models/login_model.dart';
import 'package:sport_center_project/shared/component/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginStates());

  static LoginCubit get(context) => BlocProvider.of(context);


  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(GetUserLoadingState());
  //   FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   ).then((value) {
  //     print(value.user!.email);
  //     print(value.user!.uid);
  //     emit(GetUserSuccessState(value.user!.uid));
  //   }).catchError((error){
  //     emit(GetUserErrorState(error.toString()));
  //   });
  // }

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   print("Email: $email, Password: $password");
  //   emit(GetUserLoadingState());
  //   FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   ).then((value) {
  //     print(value.user!.email);
  //     print(value.user!.uid);
  //     emit(GetUserSuccessState(value.user!.uid));
  //   }).catchError((error){
  //     emit(GetUserErrorState(error.toString()));
  //   });
  // }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _collection = FirebaseFirestore.instance.collection('users');
  Future<String> getCurrentUID() async {
    return (_firebaseAuth.currentUser!).uid;
  }

  Future<String> userLogin(String email, String password) async {
    var msg = '';
    var uid = '';
    try {
      var user = (await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password))
          .user;
      uid = user!.uid;

      print('$user');
      // add all user data to SharedPerfs
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        msg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        msg = "This isn't an email";
      }
    }
    if (msg.isEmpty) {
      print('uid1 : $uid');
      return uid;
    }
    print('msg : $msg');
    return msg;
  }

  Future<UserModel> getUser(String id) async {
    QuerySnapshot result = await _collection.where('uId', isEqualTo: id).get();
    var data = result.docs[0];
    Map<String, dynamic> userMap = {};
    userMap['uId'] = data.get('uId');
    userMap['name'] = data.get('name');
    userMap['email'] = data.get('email');
    // userMap['phone'] = data.get('phone');
    userMap['password'] = data.get('password');

    var userModel = UserModel.fromJson(userMap);
    return userModel;
  }

  Future<String> signUp(HashMap userValues) async {
    var msg = '';
    try {
      var user = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: userValues['email'], password: userValues['password']))
          .user;
      var model = UserModel(
        uId: user!.uid,
        name: userValues['name'] ?? '',
        email: userValues['email'],
        // userType: userValues['userType'],
        phone: userValues['phone'] ?? '',
        password: userValues['password'] ?? '',
        // rePassword: userValues['rePassword'] ?? '',
        image: userValues['image'] ?? '',
        // loginState: true,
        // state: true,
        isEmailVerified: true,
      );
      print(model.toMap()); // debugging statement
      await addUser(model);
      msg = user.uid;

      // add all user data to SharedPerfs
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        msg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        msg = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        msg = "This isn't an email";
      }
    } catch (e) {
      msg = '$e';
    }
    return msg;
  }

  Future<void> addUser(UserModel model) async {
    print(_collection.path); // debugging statement
    print(model.toMap()); // debugging statement
    await _collection.add(model.toMap()).catchError((error) {
      userService.handleAuthErrors(error);
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix = Icons.visibility_off_outlined;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityStates());
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

// Delete the user account from Firebase and any associated data in Firestore
  Future<void> deleteAccount() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    // Delete the user account from Firebase
    await currentUser!.delete();

    // Delete any associated data in Firestore
    final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

    // Delete the user document itself
    await userRef.delete();
  }
  // Future<void> deleteAccount() async {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //
  //   // Listen for changes in the user's authentication state
  //   FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) async {
  //     if (firebaseUser == null) {
  //       // User account has been fully deleted from Firebase
  //       final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
  //
  //       // Delete any associated data in Firestore
  //       await userRef.delete();
  //     }
  //   });
  //
  //   // Delete the user account from Firebase
  //   await currentUser!.delete();
  // }
}
