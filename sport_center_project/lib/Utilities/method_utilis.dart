import 'package:flutter/material.dart';
class MethodsUtils {

  navigator(BuildContext context, Widget widget) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  navigatorWithBack(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  double sHeight = 853;
  double sWidth = 480;

  height(BuildContext context, double h) {
    double height = h / sHeight;
    return MediaQuery.of(context).size.height * height;
  }

  double width(BuildContext context, double w) {
    double width = w / sWidth;
    return MediaQuery.of(context).size.width * width;
  }

}

MethodsUtils mUtils = MethodsUtils();
