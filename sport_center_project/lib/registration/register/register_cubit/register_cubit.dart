import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_center_project/models/login_model.dart';
import 'package:sport_center_project/registration/register/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(InitialRegisterlStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void signUp({
    required String email,
    required String name,
    required String password,
    required String phone,
  })
  {
    emit(UserRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
        ).then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          userCreate(
              name: name,
              email: email,
              phone: phone,
              uId: value.user!.uid);
          emit(UserRegisterSuccessState());
    }).catchError((error){
      emit(UserRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://www.freepik.com/free-vector/premier-soccer-football-tournament-background_7151643.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserRegisterSuccessState());
    }).catchError((error) {
      emit(UserRegisterErrorState(error.toString()));
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