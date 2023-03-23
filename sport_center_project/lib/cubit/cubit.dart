import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_center_project/cubit/states.dart';
import 'package:sport_center_project/models/login_model.dart';
import 'package:sport_center_project/shared/component/constants.dart';

class SportCenterCubit extends Cubit<SportCenterStates>{
  SportCenterCubit() :super(SportCenterInitiaState());

  static SportCenterCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

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

}