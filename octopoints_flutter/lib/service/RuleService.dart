import 'package:octopoints_flutter/service/model/Rule.dart';

abstract class RuleService {
  Future<Rule> createRule(Rule rule);
  Future<int> deleteRule(Rule rule);
  Future<List<Rule>> getRulesByMatchId(int id);
}
