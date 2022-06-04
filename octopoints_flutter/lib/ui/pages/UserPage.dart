import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/components/CreateFAB.dart';
import 'package:octopoints_flutter/ui/components/FilterableList.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/components/modal/BaseModal.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateUserModal.dart';
import 'package:octopoints_flutter/ui/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  final UserProvider _userProvider = UserProvider();

  Widget buildUserCard(User user, BuildContext context) {
    return RoundedCard(
      Container(
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
      onDelete: (() => _userProvider.deleteUser(user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User',
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: _userProvider,
        builder: (context, _) => FilterableList(
          context.select<UserProvider, Future<List<User>>>(
              (provider) => provider.getData()),
          (element, filterText) =>
              (element as User).username.contains(filterText),
          (user, context) => buildUserCard(user, context),
        ),
      ),
      floatingActionButton: CreateFAB(
        onPressed: () => BaseModal.showModal(
          context,
          ChangeNotifierProvider.value(
            value: _userProvider,
            child: CreateUserModal(),
          ),
        ),
      ),
    );
  }
}
