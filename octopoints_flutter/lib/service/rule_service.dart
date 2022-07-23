import 'package:octopoints_flutter/service/service.dart';

abstract class RuleService {
  Future<Rule> createRule(Rule rule);
  Future<int> updateRule(Rule rule);
  Future<int> deleteRule(Rule rule);
  Future<Rule?> getRuleByMatchId(int id);
}
