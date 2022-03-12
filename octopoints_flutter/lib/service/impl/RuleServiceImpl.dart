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
  Future<List<Rule>> getRulesByMatchId(int id) async {
    return (await _ruleDao.getRules(id)).map((e) => e.toRuleModel()).toList();
  }
}
