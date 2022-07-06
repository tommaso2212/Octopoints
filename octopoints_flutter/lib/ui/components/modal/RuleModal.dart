import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/components/ConfirmButton.dart';
import 'package:octopoints_flutter/ui/components/OctopointsProgressIndicator.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/components/TextInputField.dart';
import 'package:octopoints_flutter/ui/providers/RuleProvider.dart';
import 'package:provider/provider.dart';

class RuleModal extends StatefulWidget {
  final Rule rule;
  const RuleModal({required this.rule});

  @override
  State<RuleModal> createState() => _RuleModalState();
}

class _RuleModalState extends State<RuleModal> {
  String totalPointsToWin = "";
  String winners = "";

  Widget buildRuleCard(Rule rule, BuildContext context) {
    return RoundedCard(
      Column(
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
              initialValue: rule.total.toString(),
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
              initialValue: rule.winners.toString(),
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
            child: ConfirmButton(() {}),
          ),
        ],
      ),
      onDelete: () => context.read<RuleProvider>().deleteRule(rule),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RuleProvider(widget.rule),
      builder: (context, _) => buildRuleCard(context.select<RuleProvider, Rule>((value) => value.data), context),
    );
  }
}
