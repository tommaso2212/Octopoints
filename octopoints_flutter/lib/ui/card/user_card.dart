import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Container(
        margin: const EdgeInsets.only(right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.username,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.keyboard_arrow_up,
                  size: 32,
                  color: Colors.white,
                ),
                Text(
                  user.win.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 32,
                  color: Colors.white,
                ),
                Text(
                  user.lose.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onDelete: (() => context.read<UserProvider>().deleteUser(user)),
    );
  }
}