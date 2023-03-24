abstract class SportCenterStates{}

class SportCenterInitiaState extends SportCenterStates{}

class SportCenterGetUserLoadingState extends SportCenterStates{}

class SportCenterHomeState extends SportCenterStates{}

class SportCenterGetUserSuccessState extends SportCenterStates{}

class SportCenterGetUserErrorState extends SportCenterStates{
  final String error;
  SportCenterGetUserErrorState(this.error);
}

class SportCenterChangeBottomNav extends SportCenterStates{}

class SportCenterProductSuccessState extends SportCenterStates{}
class SportCenterProductErrorState extends SportCenterStates{}