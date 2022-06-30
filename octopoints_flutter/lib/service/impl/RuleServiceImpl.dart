import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/RuleDao.dart';
import 'package:octopoints_flutter/service/RuleService.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/mapper/RuleMapper.dart';

class RuleServiceImpl implements RuleService {
  final RuleDao _ruleDao = DbSingleton().db.ruleDao;

  @override
  Future<Rule> createRule(Rule rule) async {
    int id = await _ruleDao.create(rule.toRuleEntity());
    return rule.setId(id);
  }

  @override
  Future<int> deleteRule(Rule rule) {
    return _ruleDao.remove(rule.toRuleEntity());
  }

  @override
  Future<Rule?> getRuleByMatchId(int id) async {
    return await _ruleDao.getRule(id).then((value) => value.toRuleModel(),);
  }

  @override
  Future<int> updateRule(Rule rule) {
    return _ruleDao.modify([rule.toRuleEntity()]);
  }
}
