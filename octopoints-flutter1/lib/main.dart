import 'package:flutter/material.dart';
import 'package:octopoints/view/pages/HomePage.dart';
import 'package:octopoints/view/pages/SplashScreen.dart';
import 'package:octopoints/view/theme/OctopointsTheme.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Octopoints',
      debugShowCheckedModeBanner: false,
      theme: OctopointsTheme.themeData,
      initialRoute: 'init',
      routes: {
        'init': (context) => SplashScreen(),
        'home': (context) => HomePage(),
      },
    ),
  );
}
