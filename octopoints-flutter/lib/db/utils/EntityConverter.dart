import 'package:octopoints/db/entity/MatchEntity.dart';
import 'package:octopoints/db/entity/TeamEntity.dart';
import 'package:octopoints/db/entity/UserEntity.dart';
import 'package:octopoints/model/MatchModel.dart';
import 'package:octopoints/model/TeamModel.dart';
import 'package:octopoints/model/UserModel.dart';

class EntityConverter {
  static UserModel toUserModel(UserEntity u) =>
      UserModel(u.id!, u.username, u.win, u.draw, u.lose);

  static UserEntity toUserEntity(UserModel u) =>
      UserEntity(u.username, id: u.id, win: u.win, lose: u.lose, draw: u.draw);

  static MatchModel toMatchModel(MatchEntity m) => MatchModel(
      m.id, m.description, GameMode.values[m.gameMode], m.points, m.survivors);

  static MatchEntity toMatchEntity(MatchModel m) => MatchEntity(m.description,
      id: m.id,
      gameMode: m.gamemode.index,
      points: m.points,
      survivors: m.survivors);

  static TeamModel toTeamModel(TeamEntity t) =>
      TeamModel(t.id!, t.matchId, t.partial, t.total);

  static TeamEntity toTeamEntity(TeamModel t) =>
      TeamEntity(t.matchId, id: t.id, partial: t.partial, total: t.total);
}
