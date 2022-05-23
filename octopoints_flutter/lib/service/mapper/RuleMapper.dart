import 'package:octopoints_flutter/db/entity/RuleEntity.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';

extension RuleModelMapper on Rule {
  RuleEntity toRuleEntity() {
    return RuleEntity(
      id != 0 ? id : null,
      matchId,
      numVincitori,
      total,
      totalIncrement,
      partialIncrement
    );
  }

  Rule setId(int id) {
    return Rule(
      id: id,
      matchId: matchId,
      numVincitori: numVincitori,
      total: total,
      totalIncrement: totalIncrement,
      partialIncrement: partialIncrement
    );
  }
}

extension RuleEntityMapper on RuleEntity {
  Rule toRuleModel() {
    return Rule(
      id: id!,
      matchId: matchId,
      numVincitori: numVincitori,
      total: total,
      totalIncrement: totalIncrement,
      partialIncrement: partialIncrement
    );
  }
}
