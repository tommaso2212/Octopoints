import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/service.dart';

extension TeamModelExtension on Team {
  TeamEntity toTeamEntity() {
    return TeamEntity(
      id != 0 ? id : null,
      matchId,
      partial,
      total,
      status.index,
    );
  }

  Team setId(int id) {
    return Team(
      id: id,
      matchId: matchId,
      total: total,
      partial: partial,
      status: status,
    );
  }
}

extension TeamEntityExtension on TeamEntity {
  Team toTeamModel() {
    return Team(
      id: id!,
      matchId: matchId,
      total: total,
      partial: partial,
      status: TeamStatusEnum.values[status],
    );
  }
}