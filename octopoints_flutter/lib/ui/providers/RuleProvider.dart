import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/service.dart';

class RuleProvider extends ChangeNotifier{
  Rule _rule;
  RuleProvider(this._rule);

  Rule get data => _rule;

  void updateRule(Rule ruleToUpdate) async {
    await DBService.ruleService.updateRule(ruleToUpdate);
    _rule = ruleToUpdate;
  }

  void deleteRule(Rule rule) async {
    await DBService.ruleService.deleteRule(rule);
  }
}
