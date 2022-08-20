import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_button.dart';
import 'package:octopoints_flutter/ui/common_widget/number_input_field.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/providers/match_provider.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';
import 'package:provider/provider.dart';

class RuleCard extends StatefulWidget {
  final Match match;

  const RuleCard({Key? key, required this.match}) : super(key: key);

  @override
  State<RuleCard> createState() => _RuleCardState();
}

class _RuleCardState extends State<RuleCard> {
  String total = "";
  String winners = "";
  bool battleRoyale = false;

  @override
  void initState() {
    total = widget.match.rule!.total.toString();
    winners = widget.match.rule!.winners.toString();
    battleRoyale = widget.match.rule!.battleRoyale;
    super.initState();
  }

  bool validateInput(String value) {
    bool isValid = false;
    if (value.isNotEmpty && value != "0") {
      try {
        int.parse(value);
        isValid = true;
      } catch (e) {
        isValid = false;
      }
    }
    return isValid;
  }

  void updateRule(BuildContext context) async {
    widget.match.rule!.total = int.parse(total);
    widget.match.rule!.winners = int.parse(winners);
    widget.match.rule!.battleRoyale = battleRoyale;
    await context.read<MatchProvider>().updateRule(widget.match);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
            ),
            child: Text(
              widget.match.name,
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: SwitchListTile(
              value: battleRoyale,
              activeColor: OctopointsTheme.primaryColor,
              title: const Text(
                'Battle royale mode',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onChanged: (value) => setState(() {
                battleRoyale = value;
              }),
            ),
          ),
          NumberInputField(
            initialValue: total.toString(),
            label: 'Total points to ' + (battleRoyale ? 'lose' : 'win'),
            validateInput: (value) => validateInput(value),
            onChanged: (value) => setState(() => total = value),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 20,
            ),
            child: NumberInputField(
              initialValue: widget.match.rule!.winners.toString(),
              label: "Number of winners",
              validateInput: (value) => validateInput(value),
              onChanged: (value) => setState(() => winners = value),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConfirmButton(
              onPressed: validateInput(total) && validateInput(winners)
                  ? () => updateRule(context)
                  : null,
            ),
          ),
        ],
      ),
      onDelete: () {
        context.read<MatchProvider>().deleteRule(widget.match);
        Navigator.pop(context);
      },
    );
  }
}
