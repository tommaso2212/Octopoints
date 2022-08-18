import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/card/user_card.dart';
import 'package:octopoints_flutter/ui/common_widget/create_floating_action_button.dart';
import 'package:octopoints_flutter/ui/common_widget/filterable_list.dart';
import 'package:octopoints_flutter/ui/modal/base_modal.dart';
import 'package:octopoints_flutter/ui/modal/create_user_modal.dart';
import 'package:octopoints_flutter/ui/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  final UserProvider _userProvider = UserProvider();

  UserPage({Key? key}) : super(key: key);

  Widget buildListItem(BuildContext context, int index, String textFilter) {
    User user =
        context.select<UserProvider, User>((provider) => provider.data[index]);
    if (user.username.contains(textFilter)) {
      return UserCard(user: user);
    } else {
      return const SizedBox.shrink();
    }
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
          listKey: context.read<UserProvider>().listKey,
          initialItemCount: context
              .select<UserProvider, int>((provider) => provider.data.length),
          itemBuilder: (context, index, textFilter) =>
              buildListItem(context, index, textFilter),
        ),
      ),
      floatingActionButton: CreateFloatingActionButton(
        onPressed: () => BaseModal.showModal(
          context,
          ChangeNotifierProvider.value(
            value: _userProvider,
            child: const CreateUserModal(),
          ),
        ),
      ),
    );
  }
}
