// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader{
  static Future<void> showLoadingScreen(BuildContext context, GlobalKey key) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Center(child: CircularProgressIndicator(),);
        }
    );
  }
}