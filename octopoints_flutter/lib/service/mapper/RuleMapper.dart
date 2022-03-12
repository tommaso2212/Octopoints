import 'package:octopoints_flutter/db/entity/RuleEntity.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';

extension RuleModelMapper on Rule {
  RuleEntity toRuleEntity() {
    return RuleEntity(
      id != 0 ? id : null,
      matchId,
      ifArgument.index,
      ifCondition.index,
      ifValue,
      thenArgument.index,
      thenValue,
    );
  }

  Rule setId(int id) {
    return Rule(
      id: id,
      matchId: matchId,
      ifArgument: ifArgument,
      ifCondition: ifCondition,
      ifValue: ifValue,
      thenArgument: thenArgument,
      thenValue: thenValue,
    );
  }
}

extension RuleEntityMapper on RuleEntity {
  Rule toRuleModel() {
    return Rule(
      id: id!,
      matchId: matchId,
      ifArgument: RuleIfArgumentEnum.values[ifArgument],
      ifCondition: RuleIfConditionEnum.values[ifCondition],
      ifValue: ifValue,
      thenArgument: RuleThenArgumentEnum.values[thenArgument],
      thenValue: thenValue,
    );
  }
}
