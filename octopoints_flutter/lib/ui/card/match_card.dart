import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/providers/match_provider.dart';
import 'package:provider/provider.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/pages/TeamPage.dart';

class MatchCard extends StatelessWidget {
  final Match match;

  const MatchCard({Key? key, required this.match}) : super(key: key);

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
      // onLongPress: match.rule != null
      //     ? () => showMatchRule(context, match)
      //     : () => ConfirmDialog.show(
      //         context: context,
      //         title: "Create new rule?",
      //         onConfirm: () =>
      //             context.read<MatchProvider>().createMatchRule(match).then(
      //                   (value) => showMatchRule(context, match),
      //                 )),
    );
  }
}
