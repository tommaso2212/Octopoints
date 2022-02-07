import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Octopoints',
      debugShowCheckedModeBanner: false,
      //theme: OctopointsTheme.themeData,
      initialRoute: 'init',
      routes: {
        //'init': (context) => SplashScreen(),
        //'home': (context) => HomePage(),
      },
    ),
  );
}
