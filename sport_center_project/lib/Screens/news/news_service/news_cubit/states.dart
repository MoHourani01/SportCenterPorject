abstract class NewsStates{}

class NewsInitialState extends NewsStates{}


class NewsGetSportsSuccessChange extends NewsStates{}
class NewsGetSportsLoadingChange extends NewsStates{}
class NewsGetSportsErrorChange extends NewsStates{
  late final String error;
  NewsGetSportsErrorChange(this.error);
}

class NewsGetSearchSuccessChange extends NewsStates{}
class NewsGetSearchLoadingChange extends NewsStates{}
class NewsGetSearchErrorChange extends NewsStates{
  late final String error;
  NewsGetSearchErrorChange(this.error);
}
// class NewsGetChangeModeState extends NewsStates{}