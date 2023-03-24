import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late CollectionReference collection;
  final collectionName = 'users';
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
    QuerySnapshot result = await collection.where('uId', isEqualTo: id).get();
    var data = result.docs[0];
    Map<String, dynamic> userMap = {};
    userMap['uId'] = data.get('uId');
    // userMap['userName'] = data.get('userName');
    userMap['email'] = data.get('email');
    // userMap['phone'] = data.get('phone');
    userMap['password'] = data.get('password');

    var userModel = UserModel.fromJson(userMap);
    return userModel;
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
}
