import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_center_project/Screens/news/news_service/news_cubit/cubit.dart';
import 'package:sport_center_project/Screens/news/news_service/news_cubit/states.dart';
import 'package:sport_center_project/shared/component/component.dart';

class NewsSearchScreen extends StatelessWidget
{
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states){},
      builder: (context, states){
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80,
            title: Text('News Search'),
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultLoginFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (String value){
                    if (value.isEmpty){
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.search,
                  labelText: 'Search',
                ),
              ),
              Expanded(
                child: articleBuilder(
                  list,
                  context,
                  isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}