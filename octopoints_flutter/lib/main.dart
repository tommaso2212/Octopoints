import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/pages/home_page.dart';
import 'package:octopoints_flutter/ui/pages/splashscreen.dart';
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
