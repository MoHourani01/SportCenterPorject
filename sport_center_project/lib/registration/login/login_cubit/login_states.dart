abstract class LoginStates{}

class InitialLoginStates extends LoginStates{}

class GetUserLoadingState extends LoginStates{}

class GetUserSuccessState extends LoginStates{}

class GetUserErrorState extends LoginStates{
  final String error;
  GetUserErrorState(this.error,);
}

class ChangePasswordVisibilityStates extends LoginStates{}
