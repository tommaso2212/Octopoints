import 'dart:math';

import 'package:flutter/material.dart';

class OctopointsTheme {
  static ThemeData get themeData => ThemeData(
        textTheme: Typography.whiteMountainView,
        appBarTheme: AppBarTheme(
          backgroundColor: darkGrey,
          actionsIconTheme: IconThemeData(color: primaryColor),
          elevation: 15,
          titleTextStyle: TextStyle(fontSize: 22),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          elevation: 15,
        ),
        scaffoldBackgroundColor: backgroundColor,
      );
  static const Color lightGrey = Color(0xff2D3339);
  static Color get darkGrey => Color(0xff212529);
  static Color get backgroundColor => Color(0xff121417);
  static Color get primaryColor => Color(0xffEE6C4D); //orange

  static List<Color> _colors = [
    Color(0xff2D82B7), //blue
    Color(0xff42E2B8), //Aquamarine
    Color(0xffF3DFBF), //Almond
    Color(0xffEB8A90), //Coral
  ];

  static Color get randomColor =>
      _colors.elementAt(Random().nextInt(_colors.length));
}
