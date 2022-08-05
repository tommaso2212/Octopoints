import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_button.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/common_widget/text_input_field.dart';
import 'package:octopoints_flutter/ui/providers/match_provider.dart';
import 'package:provider/provider.dart';

class RuleCard extends StatelessWidget {
  final Match match;

  const RuleCard({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              match.name,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 50,
            ),
            child: TextInputField(
              initialValue: match.rule!.total.toString(),
              autoFocus: false,
              label: 'Total points to win',
              validateInput: (value) => value.isNotEmpty && value != "0",
              textInputType:
                  const TextInputType.numberWithOptions(signed: true),
              onChanged: (value) => match.rule!.total = int.parse(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 50,
            ),
            child: TextInputField(
              initialValue: match.rule!.winners.toString(),
              autoFocus: false,
              label: "Number of winners",
              validateInput: (value) => value.isNotEmpty && value != "0",
              textInputType:
                  const TextInputType.numberWithOptions(signed: true),
              onChanged: (value) => match.rule!.winners = int.parse(value),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConfirmButton(
                onPressed: match.rule!.total.toString().isNotEmpty &&
                        match.rule!.total.toString() != "0" &&
                        match.rule!.winners.toString().isNotEmpty &&
                        match.rule!.winners.toString() != "0"
                    ? () =>
                        context.read<MatchProvider>().updateRule(match).then(
                              (_) => Navigator.pop(context),
                            )
                    : null),
          ),
        ],
      ),
      onDelete: () {
        context.read<MatchProvider>().deleteRule(match);
        Navigator.pop(context);
      },
    );
  }
}
