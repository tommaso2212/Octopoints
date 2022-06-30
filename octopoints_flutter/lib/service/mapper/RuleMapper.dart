import 'package:octopoints_flutter/db/entity/RuleEntity.dart';
import 'package:octopoints_flutter/service/model/Rule.dart';

extension RuleModelMapper on Rule {
  RuleEntity toRuleEntity() {
    return RuleEntity(
      id != 0 ? id : null,
      matchId,
      winners,
      total,
    );
  }

  Rule setId(int id) {
    return Rule(
      id: id,
      matchId: matchId,
      winners: winners,
      total: total,
    );
  }
}

extension RuleEntityMapper on RuleEntity? {
  Rule? toRuleModel() {
    return this != null ? Rule(
      id: this!.id!,
      matchId: this!.matchId,
      winners: this!.winners,
      total: this!.total,
    ):null;
  }
}
