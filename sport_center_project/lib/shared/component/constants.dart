// List<Map> tasks = [];


// https://newsapi.org/
// v2/everything?
// q=tesla&from=2022-07-10&sortBy=publishedAt&apiKey=API_KEY


// https://newsapi.org/
// v2/top-headlines?
// country=us&category=business&apiKey=7677dda70123483dbfb39118dc337c1a

// https://newsapi.org/
// v2/everything?
// q=tesla&apiKey=7677dda70123483dbfb39118dc337c1a

import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/shared/network/local/cache_helper.dart';

dynamic signOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    navigators.navigateTo(context, LoginScreen());
  });
}

void printFullText(String text){
  final patten=RegExp('.{1,800}');
  patten.allMatches(text).forEach((match)=>print(match.group(0)));
}

String token='';
String uId='';
