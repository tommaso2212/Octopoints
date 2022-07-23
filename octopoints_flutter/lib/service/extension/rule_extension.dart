import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/service.dart';

extension RuleModelExtension on Rule {
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

extension RuleEntityExtension on RuleEntity? {
  Rule? toRuleModel() {
    return this != null ? Rule(
      id: this!.id!,
      matchId: this!.matchId,
      winners: this!.winners,
      total: this!.total,
    ):null;
  }
}
