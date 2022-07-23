import 'package:octopoints_flutter/service/service.dart';

class RuleServiceImpl extends OctopointsService implements RuleService {
  @override
  Future<Rule> createRule(Rule rule) async {
    int id = await db.ruleDao.create(rule.toRuleEntity());
    return rule.setId(id);
  }

  @override
  Future<int> deleteRule(Rule rule) {
    return db.ruleDao.remove(rule.toRuleEntity());
  }

  @override
  Future<Rule?> getRuleByMatchId(int id) async {
    return await db.ruleDao.getRule(id).then(
          (value) => value.toRuleModel(),
        );
  }

  @override
  Future<int> updateRule(Rule rule) {
    return db.ruleDao.modify([rule.toRuleEntity()]);
  }
}
