import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_center_project/Screens/news/news_service/news_cubit/cubit.dart';
import 'package:sport_center_project/Screens/news/news_service/news_cubit/states.dart';
import 'package:sport_center_project/shared/component/component.dart';

class SportsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).sports;
        /*
        return ConditionalBuilder(
          // condition: state is! NewsGetSportsLoadingChange,
          condition: list.length>0,
          builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildArticleItem(list[index]),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: 10),
          fallback: (context)=>Center(child: CircularProgressIndicator()),);*/
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80,
            title: Text('Sport News'),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF030A59),
                    Color(0xFF121879),
                    Color(0xFF2931A8),
                  ],
                  begin: AlignmentDirectional.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
                     ),
          body: articleBuilder(list,context),
        );
      },);
  }
}