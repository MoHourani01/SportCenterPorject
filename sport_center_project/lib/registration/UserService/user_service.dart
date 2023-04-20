import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sport_center_project/models/login_model.dart';

class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference collection;
  final collectionName = 'users';

  int statusCode = 0;
  String msg = '';

  UserService() {
    collection = _firestore.collection(collectionName);
  }

  // Future<String> getCurrentUID() async {
  //   return (_firebaseAuth.currentUser!).uid;
  // }
  //
  // Future<String> signIn(String email, String password) async {
  //   var msg = '';
  //   var uid = '';
  //   try {
  //     var user = (await _firebaseAuth.signInWithEmailAndPassword(
  //             email: email, password: password))
  //         .user;
  //     uid = user!.uid;
  //
  //     log('$user');
  //     // add all user data to SharedPerfs
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       msg = 'No user found for that email.';
  //     } else if (e.code == 'wrong-password') {
  //       msg = 'Wrong password provided for that user.';
  //     } else if (e.code == 'invalid-email') {
  //       msg = "This isn't an email";
  //     }
  //   }
  //   if (msg.isEmpty) {
  //     log('uid1 : $uid');
  //     return uid;
  //   }
  //   log('msg : $msg');
  //   return msg;
  // }
  //
  // Future<String> signUp(HashMap userValues) async {
  //   var msg = '';
  //   try {
  //     var user = (await _firebaseAuth.createUserWithEmailAndPassword(
  //             email: userValues['email'], password: userValues['password']))
  //         .user;
  //     var model = UserModel(
  //       uId: user!.uid,
  //       name: userValues['name'] ?? '',
  //       email: userValues['email'],
  //       // userType: userValues['userType'],
  //       phone: userValues['phone'] ?? '',
  //       password: userValues['password'] ?? '',
  //       // rePassword: userValues['rePassword'] ?? '',
  //       image: userValues['image'] ?? '',
  //       // loginState: true,
  //       // state: true,
  //       isEmailVerified: true,
  //     );
  //     await addUser(model);
  //     msg = user.uid;
  //
  //     // add all user data to SharedPerfs
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       msg = 'The password provided is too weak.';
  //     } else if (e.code == 'email-already-in-use') {
  //       msg = 'The account already exists for that email.';
  //     } else if (e.code == 'invalid-email') {
  //       msg = "This isn't an email";
  //     }
  //   } catch (e) {
  //     msg = '$e';
  //   }
  //   return msg;
  // }
  //
  // Future<void> addUser(UserModel model) async {
  //   await collection.add(model.toMap()).catchError((error) {
  //     handleAuthErrors(error);
  //   });
  // }
  //
  // Future<UserModel?> getUser(String id) async {
  //   QuerySnapshot result = await collection.where('uid', isEqualTo: id).get();
  //   if (result == null || result.docs.isEmpty) {
  //     // Handle the case where there are no documents that match the query.
  //     return null;
  //   }
  //   var data = result.docs[0];
  //   Map<String, dynamic> userMap = {};
  //   userMap['uid'] = data.get('uid');
  //   userMap['userName'] = data.get('userName');
  //   userMap['email'] = data.get('email');
  //   userMap['phone'] = data.get('phone');
  //   userMap['password'] = data.get('password');
  //   userMap['userType'] = data.get('userType');
  //   userMap['rePassword'] = data.get('rePassword');
  //   userMap['loginState'] = data.get('loginState');
  //   userMap['state'] = data.get('state');
  //   userMap['imageUrl'] = data.get('imageUrl');
  //
  //   var userModel = UserModel.fromJson(userMap);
  //   return userModel;
  // }
  //
  //
  // // Future<UserList> getVendorUsers() async {
  // //   QuerySnapshot vendorResult = await collection.where('userType',isEqualTo: 'vendor').get();
  // //   List<UserModel> userDataList = [];
  // //   Map<String, dynamic> userMap = {};
  // //   for (var data in vendorResult.docs) {
  // //     userMap['uid'] = data.get('uid');
  // //     userMap['userName'] = data.get('userName');
  // //     userMap['email'] = data.get('email');
  // //     userMap['phone'] = data.get('phone');
  // //     userMap['password'] = data.get('password');
  // //     userMap['userType'] = data.get('userType');
  // //     userMap['rePassword'] = data.get('rePassword');
  // //     userMap['loginState'] = data.get('loginState');
  // //     userMap['state'] = data.get('state');
  // //     userMap['imageUrl'] = data.get('imageUrl');
  // //     var userModel = UserModel.fromJson(userMap);
  // //     userDataList.add(userModel);
  // //   }
  // //   return UserList(users: userDataList);
  // // }
  //
  // // Future<UserList> getCustomerUsers() async {
  // //   QuerySnapshot customerResult = await collection.where('userType',isEqualTo: 'customer').get();
  // //   List<UserModel> userDataList = [];
  // //   Map<String, dynamic> userMap = {};
  // //   for (var data in customerResult.docs) {
  // //     userMap['uid'] = data.get('uid');
  // //     userMap['userName'] = data.get('userName');
  // //     userMap['email'] = data.get('email');
  // //     userMap['phone'] = data.get('phone');
  // //     userMap['password'] = data.get('password');
  // //     userMap['userType'] = data.get('userType');
  // //     userMap['rePassword'] = data.get('rePassword');
  // //     userMap['loginState'] = data.get('loginState');
  // //     userMap['state'] = data.get('state');
  // //     userMap['imageUrl'] = data.get('imageUrl');
  // //     var userModel = UserModel.fromJson(userMap);
  // //     userDataList.add(userModel);
  // //   }
  // //   return UserList(users: userDataList);
  // // }


  // Future<void> logout() async {
  //   await _firebaseAuth.signOut();
  // }

  void handleAuthErrors(ArgumentError error) {
    String errorCode = error.message;
    switch (errorCode) {
      case "ABORTED":
        {
          statusCode = 400;
          msg = "The operation was aborted";
          log(msg);
        }
        break;
      case "ALREADY_EXISTS":
        {
          statusCode = 400;
          msg = "Some document that we attempted to create already exists.";
          log(msg);
        }
        break;
      case "CANCELLED":
        {
          statusCode = 400;
          msg = "The operation was cancelled";
          log(msg);
        }
        break;
      case "DATA_LOSS":
        {
          statusCode = 400;
          msg = "Unrecoverable data loss or corruption.";
          log(msg);
        }
        break;
      case "PERMISSION_DENIED":
        {
          statusCode = 400;
          msg =
              "The caller does not have permission to execute the specified operation.";
          log(msg);
        }
        break;
      default:
        {
          statusCode = 400;
          msg = error.message;
          log(msg);
        }
        break;
    }
  }
}

UserService userService = UserService();
