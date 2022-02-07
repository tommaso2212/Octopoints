import 'package:flutter/material.dart';
import 'package:octopoints/model/UserModel.dart';
import 'package:octopoints/view/pages/BasePage.dart';
import 'package:octopoints/view/widget/card/UserCard.dart';
import 'package:octopoints/view/widget/widget.dart';

class UserPage extends BasePage<UserModel> {
  @override
  AppBar appBar(_) => AppBar(
        title: Text(
          'Giocatori',
        ),
      );

  @override
  Widget buildCard(BuildContext context, UserModel user) => UserCard(user);

  @override
  Widget modalBottomSheet(BuildContext context) => CreateUserModal(context);
}
