import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/components/ConfirmButton.dart';
import 'package:octopoints_flutter/ui/components/TextInputField.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateModal.dart';
import 'package:octopoints_flutter/ui/providers/RuleProvider.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';
import 'package:provider/provider.dart';

class CreateRuleModal extends StatefulWidget {
  final Match _match;
  CreateRuleModal(this._match);

  @override
  State<CreateRuleModal> createState() => _CreateRuleModalState();
}

class _CreateRuleModalState extends State<CreateRuleModal> {
  RuleIfArgumentEnum ruleIfArgumentEnum = RuleIfArgumentEnum.total;
  RuleIfConditionEnum ruleIfConditionEnum = RuleIfConditionEnum.greater;
  TextEditingController ruleIfValue = TextEditingController(text: "3");
  bool isRuleIfValue = true;
  RuleThenArgumentEnum ruleThenArgumentEnum = RuleThenArgumentEnum.teamStatus;
  TextEditingController ruleThenValueController = TextEditingController(text: TeamStatusEnum.win.index.toString());
  bool isRuleThenValue = true;
  TeamStatusEnum ruleThenValueTeamStatus = TeamStatusEnum.win;

  void onConfirm(BuildContext context) {

    int? thenValue;
    if(ruleThenArgumentEnum == RuleThenArgumentEnum.teamStatus){
      thenValue = ruleThenValueTeamStatus.index;
    } else if(ruleThenArgumentEnum == RuleThenArgumentEnum.total){
      thenValue =  int.parse(ruleThenValueController.text);
    }
    context.read<RuleProvider>().createRule(
          Rule(
            matchId: widget._match.id,
            ifArgument: ruleIfArgumentEnum,
            ifCondition: ruleIfConditionEnum,
            ifValue: int.parse(ruleIfValue.text),
            thenArgument: ruleThenArgumentEnum,
            thenValue: thenValue,
          ),
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 14),
          child: Text(
            "Aggiungi regola",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Wrap(
            spacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                "Se:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              DropdownButton<RuleIfArgumentEnum>(
                value: ruleIfArgumentEnum,
                dropdownColor: OctopointsTheme.darkGrey,
                borderRadius: BorderRadius.circular(10),
                underline: Container(
                  height: 2,
                  color: OctopointsTheme.primaryColor,
                ),
                onChanged: (value) => setState(() {
                  if (value != null) {
                    ruleIfArgumentEnum = value;
                  }
                }),
                items: [
                  DropdownMenuItem(
                    child: Text(RuleIfArgumentEnum.total.name),
                    value: RuleIfArgumentEnum.total,
                  ),
                  DropdownMenuItem(
                    child: Text(RuleIfArgumentEnum.partial.name),
                    value: RuleIfArgumentEnum.partial,
                  ),
                  DropdownMenuItem(
                    child: Text(RuleIfArgumentEnum.winners.name),
                    value: RuleIfArgumentEnum.winners,
                  ),
                  DropdownMenuItem(
                    child: Text(RuleIfArgumentEnum.losers.name),
                    value: RuleIfArgumentEnum.losers,
                  ),
                ],
              ),
              DropdownButton<RuleIfConditionEnum>(
                value: ruleIfConditionEnum,
                dropdownColor: OctopointsTheme.darkGrey,
                borderRadius: BorderRadius.circular(10),
                underline: Container(
                  height: 2,
                  color: OctopointsTheme.primaryColor,
                ),
                onChanged: (value) => setState(() {
                  if (value != null) {
                    ruleIfConditionEnum = value;
                  }
                }),
                items: [
                  DropdownMenuItem(
                    child: Text(RuleIfConditionEnum.equals.name),
                    value: RuleIfConditionEnum.equals,
                  ),
                  DropdownMenuItem(
                    child: Text(RuleIfConditionEnum.greater.name),
                    value: RuleIfConditionEnum.greater,
                  ),
                  DropdownMenuItem(
                    child: Text(RuleIfConditionEnum.less.name),
                    value: RuleIfConditionEnum.less,
                  ),
                ],
              ),
              SizedBox(
                width: 80,
                child: TextInputField(
                  controller: ruleIfValue,
                  label: '',
                  textInputType:
                      const TextInputType.numberWithOptions(signed: true),
                  autoFocus: false,
                  onChanged: () => setState(() {
                    isRuleIfValue = ruleIfValue.text.isNotEmpty;
                  }),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Wrap(
            spacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                "Allora:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              DropdownButton<RuleThenArgumentEnum>(
                value: ruleThenArgumentEnum,
                dropdownColor: OctopointsTheme.darkGrey,
                borderRadius: BorderRadius.circular(10),
                underline: Container(
                  height: 2,
                  color: OctopointsTheme.primaryColor,
                ),
                onChanged: (value) => setState(() {
                  if (value != null) {
                    ruleThenArgumentEnum = value;
                    if(ruleThenArgumentEnum != RuleThenArgumentEnum.total){
                      isRuleThenValue = true;
                    }
                  }
                }),
                items: [
                  DropdownMenuItem(
                    child: Text(RuleThenArgumentEnum.total.name),
                    value: RuleThenArgumentEnum.total,
                  ),
                  DropdownMenuItem(
                    child: Text(RuleThenArgumentEnum.teamStatus.name),
                    value: RuleThenArgumentEnum.teamStatus
                  ),
                  DropdownMenuItem(
                    child: Text(RuleThenArgumentEnum.endGame.name),
                    value: RuleThenArgumentEnum.endGame,
                  ),
                ],
              ),
              ruleThenArgumentEnum == RuleThenArgumentEnum.endGame ? const SizedBox.shrink() :
              ruleThenArgumentEnum == RuleThenArgumentEnum.total ?
              SizedBox(
                width: 80,
                child: TextInputField(
                  controller: ruleThenValueController,
                  label: 'Numero',
                  textInputType:
                      const TextInputType.numberWithOptions(signed: true),
                  autoFocus: false,
                  onChanged: () => setState(() {
                    isRuleThenValue = ruleThenValueController.text.isNotEmpty;
                  }),
                ),
              ) : DropdownButton<TeamStatusEnum>(
                value: ruleThenValueTeamStatus,
                dropdownColor: OctopointsTheme.darkGrey,
                borderRadius: BorderRadius.circular(10),
                underline: Container(
                  height: 2,
                  color: OctopointsTheme.primaryColor,
                ),
                onChanged: (value) => setState(() {
                  if (value != null) {
                    ruleThenValueTeamStatus = value;
                  }
                }),
                items: [
                  DropdownMenuItem(
                    child: Text(TeamStatusEnum.win.name),
                    value: TeamStatusEnum.win,
                  ),
                  DropdownMenuItem(
                    child: Text(TeamStatusEnum.lose.name),
                    value: TeamStatusEnum.lose,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConfirmButton(
            isRuleIfValue && isRuleThenValue ?
            () => onConfirm(context) : null,
          ),
        ),
      ],
    );
  }
}
