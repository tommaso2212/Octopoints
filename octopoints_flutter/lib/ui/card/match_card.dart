import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/card/rule_card.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_dialog.dart';
import 'package:octopoints_flutter/ui/modal/base_modal.dart';
import 'package:octopoints_flutter/ui/providers/match_provider.dart';
import 'package:provider/provider.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/pages/TeamPage.dart';

class MatchCard extends StatelessWidget {
  final Match match;

  const MatchCard({Key? key, required this.match}) : super(key: key);

  void showRuleModal(BuildContext context) {
    BaseModal.showModal(
      context,
      ChangeNotifierProvider.value(
        value: context.read<MatchProvider>(),
        child: RuleCard(
          match: match,
        ),
      ),
    );
  }

  void showCreateRuleDialog(BuildContext context) {
    ConfirmDialog.show(
      context: context,
      title: "Create new rule?",
      onConfirm: () async {
        await context.read<MatchProvider>().createMatchRule(match);
        showRuleModal(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
        child: Container(
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
        onDelete: () => context.read<MatchProvider>().removeItem(match),
        onLongPress: match.rule != null
            ? () => showRuleModal(context)
            : () => showCreateRuleDialog(context));
  }
}
