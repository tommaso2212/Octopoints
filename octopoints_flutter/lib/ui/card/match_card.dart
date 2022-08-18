import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/card/rule_card.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_dialog.dart';
import 'package:octopoints_flutter/ui/modal/base_modal.dart';
import 'package:octopoints_flutter/ui/providers/match_provider.dart';
import 'package:provider/provider.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/pages/team_page.dart';

class MatchCard extends StatefulWidget {
  final Match match;

  const MatchCard({Key? key, required this.match}) : super(key: key);

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  void showRuleModal(BuildContext context) {
    BaseModal.showModal(
      context,
      ChangeNotifierProvider.value(
        value: context.read<MatchProvider>(),
        child: RuleCard(
          match: widget.match,
        ),
      ),
    );
  }

  void showCreateRuleDialog(BuildContext context) {
    ConfirmDialog.show(
      context: context,
      title: "Create new rule?",
      onConfirm: () async {
        Rule rule =
            await context.read<MatchProvider>().createMatchRule(widget.match);
        setState(() {
          widget.match.rule = rule;
        });
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
            widget.match.name,
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
                builder: (context) => TeamPage(match: widget.match),
              ),
            ),
        onDelete: () => context.read<MatchProvider>().removeItem(widget.match),
        onLongPress: widget.match.rule != null
            ? () => showRuleModal(context)
            : () => showCreateRuleDialog(context));
  }
}
