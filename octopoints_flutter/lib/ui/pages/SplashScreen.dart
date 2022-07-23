import 'package:flutter/material.dart';
import 'package:octopoints_flutter/db/db_singleton.dart';
import 'package:octopoints_flutter/ui/common_widget/octopoints_progress_indicator.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    DbSingleton().initDb().then((value) => Navigator.pushReplacementNamed(context, 'home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Octopoints',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              ),
            ),
            OctopointsProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
