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


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(GetUserLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(GetUserSuccessState(value.user!.uid));
    }).catchError((error){
      emit(GetUserErrorState(error.toString()));
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
}
