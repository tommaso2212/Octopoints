import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/rule.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_button.dart';
import 'package:octopoints_flutter/ui/common_widget/octopoints_progress_indicator.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/common_widget/text_input_field.dart';
import 'package:octopoints_flutter/ui/providers/RuleProvider.dart';
import 'package:provider/provider.dart';

class RuleModal extends StatefulWidget {
  final Match match;
  const RuleModal({required this.match});

  @override
  State<RuleModal> createState() => _RuleModalState();
}

class _RuleModalState extends State<RuleModal> {
  String totalPointsToWin = "";
  String winners = "";

  @override
  void initState() {
    totalPointsToWin = widget.match.rule!.total.toString();
    winners = widget.match.rule!.winners.toString();
    super.initState();
  }

  Widget buildRuleCard(Rule rule, BuildContext context) {
    return RoundedCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              "Rule",
              style: TextStyle(
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
              initialValue: totalPointsToWin,
              autoFocus: false,
              label: 'Total points to win',
              validateInput: (value) => value.isNotEmpty && value != "0",
              textInputType:
                  const TextInputType.numberWithOptions(signed: true),
              onChanged: (value) => setState(() {
                totalPointsToWin = value;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 50,
            ),
            child: TextInputField(
              initialValue: winners,
              autoFocus: false,
              label: "Number of winners",
              validateInput: (value) => value.isNotEmpty && value != "0",
              textInputType:
                  const TextInputType.numberWithOptions(signed: true),
              onChanged: (value) => setState(() {
                winners = value;
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConfirmButton(
                onPressed: totalPointsToWin.isNotEmpty &&
                        totalPointsToWin != "0" &&
                        winners.isNotEmpty &&
                        winners != "0"
                    ? () => context
                        .read<RuleProvider>()
                        .updateRule(
                          rule
                              .setTotal(int.parse(totalPointsToWin))
                              .setWinners(int.parse(winners)),
                        )
                        .then((value) => Navigator.pop(context))
                    : null),
          ),
        ],
      ),
      onDelete: () {
        context.read<RuleProvider>().deleteRule(rule);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RuleProvider(widget.match),
      builder: (context, _) => buildRuleCard(
          context.select<RuleProvider, Rule>((value) => value.data), context),
    );
  }
}
