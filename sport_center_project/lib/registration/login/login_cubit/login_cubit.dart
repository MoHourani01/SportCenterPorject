import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(InitialLoginStates());

  static LoginCubit get(context) => BlocProvider.of(context);
}

