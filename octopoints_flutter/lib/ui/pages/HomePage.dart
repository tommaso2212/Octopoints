import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/match.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_dialog.dart';
import 'package:octopoints_flutter/ui/common_widget/create_floating_action_button.dart';
import 'package:octopoints_flutter/ui/components/FilterableList.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/components/modal/BaseModal.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateMatchModal.dart';
import 'package:octopoints_flutter/ui/components/modal/RuleModal.dart';
import 'package:octopoints_flutter/ui/pages/TeamPage.dart';
import 'package:octopoints_flutter/ui/pages/UserPage.dart';
import 'package:octopoints_flutter/ui/providers/MatchProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final MatchProvider _matchProvider = MatchProvider();

  void showMatchRule(BuildContext context, Match match) {
    BaseModal.showModal(
      context,
      RuleModal(
        match: match,
      ),
    ).then((_) => context.read<MatchProvider>().notifyListeners());
  }

  Widget buildMatchCard(Match match, BuildContext context) {
    return RoundedCard(
      Container(
        margin: const EdgeInsets.only(right: 40),
        child: Text(
          match.name,
          overflow: TextOverflow.clip,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeamPage(match),
        ),
      ),
      onDelete: (() => _matchProvider.deleteMatch(match)),
      onLongPress: match.rule != null
          ? () => showMatchRule(context, match)
          : () => ConfirmDialog.show(context: context, title: "Create new rule?").then(
              (value) => value!
                  ? context
                      .read<MatchProvider>()
                      .createMatchRule(match)
                      .then((value) => showMatchRule(context, match))
                  : null),
    );
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
                builder: (context) => UserPage(), //user page
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
          list: context.select<MatchProvider, Future<List<Match>>>(
              (provider) => provider.data),
          filterListByText: (element, filterText) =>
              (element as Match).name.contains(filterText),
          elementToWidget: (match, context) => buildMatchCard(match, context),
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
