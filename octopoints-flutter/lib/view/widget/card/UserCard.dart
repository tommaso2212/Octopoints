import 'package:flutter/material.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/provider/provider.dart';
import 'package:octopoints/view/widget/card/RoundedCard.dart';

class UserCard extends StatelessWidget {
  final UserModel _user;

  UserCard(this._user);

  @override
  Widget build(BuildContext context) => RoundedCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  _user.username,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                      ),
                      Text(
                        _user.win.toString(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      Text(
                        _user.lose.toString(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        onDelete: () => context.read<IProvider<UserModel>>().remove(_user),
      );
}
