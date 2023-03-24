
import 'package:flutter/material.dart';

class WidgetUtils{
  Widget text(
      String text, {
        double size = 14,
        Color color = Colors.black,
        FontWeight fontWeight = FontWeight.normal,
        double height = 1.5,
        TextAlign align = TextAlign.start,
        TextOverflow? overFlow,
        TextDirection? direction,
        int? maxLines,
        FontStyle? fontStyle

      }) {
    return Text(text,
        textDirection: direction,
        maxLines: maxLines,
        style: TextStyle(
          fontStyle: fontStyle,
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          height: height,
          overflow: overFlow,
        ));
  }
}

WidgetUtils wUtils = WidgetUtils();