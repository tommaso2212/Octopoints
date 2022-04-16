import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/OctopointsProvider.dart';

class RuleProvider extends OctopointsProvider<Rule> {
  final Match _match;
  RuleProvider(this._match);

  @override
  Future<List<Rule>> getData() async {
    return Future.value(_match.rules);
  }

  void createRule(Rule rule) async {
    create(await DBService.ruleService.createRule(rule));
  }

  void deleteRule(Rule rule) async {
    await DBService.ruleService.deleteRule(rule);
    delete(rule);
  }
}