import 'package:flutter/material.dart';

class OctopointsTheme {
  static ThemeData get themeData => ThemeData(
        textTheme: Typography.whiteMountainView,
        appBarTheme: const AppBarTheme(
          backgroundColor: darkGrey,
          actionsIconTheme: IconThemeData(color: primaryColor),
          elevation: 15,
          titleTextStyle: TextStyle(fontSize: 22),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          elevation: 15,
        ),
        scaffoldBackgroundColor: backgroundColor,
      );
  static const Color lightGrey = Color(0xff2D3339);
  static const Color darkGrey = Color(0xff212529);
  static const Color backgroundColor = Color(0xff121417);
  static const Color primaryColor = Color(0xffEE6C4D);
  static const Color textColor = Color(0xffffffff);

}
