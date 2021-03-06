import 'package:flutter/material.dart';
import 'package:octopoints/db/db.dart';
import 'package:octopoints/view/widget/widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    DbSingleton()
        .initDb()
        .then((_) => Navigator.pushReplacementNamed(context, 'home'));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Octopoints',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40),
                ),
              ),
              CommonProgressIndicator(),
            ],
          ),
        ),
      );
}
