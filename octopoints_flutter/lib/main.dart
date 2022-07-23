import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/pages/HomePage.dart';
import 'package:octopoints_flutter/ui/pages/SplashScreen.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';

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
