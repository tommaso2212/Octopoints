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
  final Match match;

  const RuleModal({required this.match});

  @override
  State<RuleModal> createState() => _RuleModalState();
}

class _RuleModalState extends State<RuleModal> {
  Widget buildRuleCard(Rule rule, BuildContext context) {
    print(rule.id);
    return RoundedCard(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              widget.match.name,
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
              initialValue: rule.total.toString(),
              autoFocus: false,
              label: "Total points to win",
              validateInput: (value) => value.isNotEmpty && value != "0",
              textInputType:
                  const TextInputType.numberWithOptions(signed: true),
              onChanged: (value) => context.read<RuleProvider>().updateRule(
                    rule.setTotal(
                      int.parse(value),
                    ),
                  ),
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
              onChanged: (value) => context.read<RuleProvider>().updateRule(
                    rule.setWinners(
                      int.parse(value),
                    ),
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
          ),
        ],
      ),
      onDelete: () => context.read<RuleProvider>().deleteRule(rule),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RuleProvider(widget.match),
      builder: (context, _) => FutureBuilder(
        future: context
            .select<RuleProvider, Future<Rule?>>((provider) => provider.data),
        builder: (context, AsyncSnapshot<Rule?> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return OctopointsProgressIndicator();
          } else if (snap.hasError) {
            return Text("Error: " + snap.error.toString());
          } else if (snap.hasData) {
            return buildRuleCard(snap.data!, context);
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Add new rule?",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ConfirmButton(
                () => context.read<RuleProvider>().createRule(),
              ),
            ],
          );
        },
      ),
    );
  }
}
