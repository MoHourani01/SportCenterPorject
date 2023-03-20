abstract class RegisterStates{}

class InitialRegisterlStates extends RegisterStates{}

class UserRegisterLoadingState extends RegisterStates{}

class UserRegisterSuccessState extends RegisterStates{}

class UserRegisterErrorState extends RegisterStates{
  final String error;
  UserRegisterErrorState(this.error,);
}

class ChangePasswordVisibilityStates extends RegisterStates{}
