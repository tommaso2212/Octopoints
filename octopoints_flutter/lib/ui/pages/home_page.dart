import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/card/match_card.dart';
import 'package:octopoints_flutter/ui/common_widget/create_floating_action_button.dart';
import 'package:octopoints_flutter/ui/common_widget/filterable_list.dart';
import 'package:octopoints_flutter/ui/modal/base_modal.dart';
import 'package:octopoints_flutter/ui/modal/create_match_modal.dart';
import 'package:octopoints_flutter/ui/pages/user_page.dart';
import 'package:octopoints_flutter/ui/providers/match_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final MatchProvider _matchProvider = MatchProvider();

  HomePage({Key? key}) : super(key: key);

  // void showMatchRule(BuildContext context, Match match) {
  //   BaseModal.showModal(
  //     context,
  //     RuleModal(
  //       match: match,
  //     ),
  //   ).then((_) => context.read<MatchProvider>().notifyListeners());
  // }

  Widget buildMatch(BuildContext context, int index, String textFilter) {
    Match match = context
        .select<MatchProvider, Match>((provider) => provider.data[index]);
    if (match.name.contains(textFilter)) {
      return MatchCard(match: match);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
            icon: const Icon(
              Icons.supervised_user_circle,
              size: 35,
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: _matchProvider,
        builder: (context, _) => FilterableList(
          listKey: context.read<MatchProvider>().listKey,
          itemCount: context
              .select<MatchProvider, int>((provider) => provider.data.length),
          itemBuilderFiltered: (context, index, textFilter) => buildMatch(
            context,
            index,
            textFilter,
          ),
        ),
      ),
      floatingActionButton: CreateFloatingActionButton(
        onPressed: () => BaseModal.showModal(
          context,
          ChangeNotifierProvider.value(
            value: _matchProvider,
            child: CreateMatchModal(),
          ),
        ),
      ),
    );
  }
}
