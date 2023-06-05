import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sport_center_project/Screens/news/news_service/news_cubit/states.dart';
import 'package:sport_center_project/Screens/news/news_service/sports/sports_screen.dart';
import 'package:sport_center_project/shared/network/shared.network.remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int current_index = 0;
  List<Widget> screens = [
    SportsScreen(),
  ];

  List<dynamic> sports=[];
  void getSports(){
    emit(NewsGetSportsLoadingChange());
    if (sports.length==0){
      DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sports',
          'apiKey':'7677dda70123483dbfb39118dc337c1a'
        },
      ).then((value) {
        // print(value.data.toString());
        // print(value.data['totalResults']);
        // print(value.data['articles'][0]['title']);
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessChange());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorChange(error.toString()));
      });
    }
    else {
      emit(NewsGetSportsSuccessChange());
    }
  }
}