import 'package:octopoints_flutter/db/entity/TeamEntity.dart';
import 'package:octopoints_flutter/service/model/Team.dart';

extension TeamModelMapper on Team {
  TeamEntity toTeamEntity() {
    return TeamEntity(
      id != 0 ? id : null,
      matchId,
      name,
      partial,
      total,
      status.index,
    );
  }

  Team setId(int id) {
    return Team(
      id: id,
      matchId: matchId,
      name: name,
      total: total,
      partial: partial,
      status: status,
    );
  }
}

extension TeamEntityMapper on TeamEntity {
  Team toTeamModel() {
    return Team(
      id: id!,
      matchId: matchId,
      name: name,
      total: total,
      partial: partial,
      status: TeamStatusEnum.values[status],
    );
  }
}
