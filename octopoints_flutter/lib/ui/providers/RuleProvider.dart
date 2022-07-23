import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/rule.dart';
import 'package:octopoints_flutter/service/service.dart';

class RuleProvider extends ChangeNotifier {
  Match _match;
  RuleProvider(this._match);

  Rule get data => _match.rule!;

  Future updateRule(Rule ruleToUpdate) async {
    await OctopointsService.ruleService.updateRule(ruleToUpdate);
    _match.rule = ruleToUpdate;
  }

  void deleteRule(Rule rule) async {
    await OctopointsService.ruleService.deleteRule(rule);
    _match.rule = null;
  }
}
