import 'package:flutter/material.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/view/pages/BasePage.dart';
import 'package:octopoints/view/pages/UserPage.dart';
import 'package:octopoints/view/widget/widget.dart';

class HomePage extends BasePage<MatchModel> {
  @override
  Widget buildCard(BuildContext context, MatchModel match) => MatchCard(match);

  @override
  AppBar appBar(BuildContext context) => AppBar(
        title: Text(
          'Octopoints',
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPage(),
              ),
            ),
            icon: Icon(
              Icons.supervised_user_circle,
              size: 35,
            ),
          ),
        ],
      );

  @override
  Widget modalBottomSheet(BuildContext context) => CreateMatchModal(context);
}
