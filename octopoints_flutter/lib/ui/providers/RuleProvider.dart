import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/service.dart';

class RuleProvider extends ChangeNotifier{
  final Match _match;
  RuleProvider(this._match);

  Future<Rule?> get data => _match.rule != null ? Future.value(_match.rule) : getData().then((value) => _match.rule = value);

  Future<Rule?> getData() async {
    return DBService.ruleService.getRuleByMatchId(_match.id);
  }

  void createRule() async {
    _match.rule = await DBService.ruleService.createRule(Rule(matchId: _match.id, winners: 0, total: 0));
  }

  void updateRule(Rule ruleToUpdate) async {
    await DBService.ruleService.updateRule(ruleToUpdate);
    _match.rule = ruleToUpdate;
  }

  void deleteRule(Rule rule) async {
    await DBService.ruleService.deleteRule(rule);
    _match.rule = null;
    notifyListeners();
  }
}
