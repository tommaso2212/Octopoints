import 'package:octopoints/db/db.dart';
import 'package:octopoints/model/model.dart';

class EntityDto {
  static UserModel toUserModel(UserEntity u) =>
      UserModel(u.id!, u.username, u.win, u.lose);

  static UserEntity toUserEntity(UserModel u) =>
      UserEntity(u.username, id: u.id, win: u.win, lose: u.lose);

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

  static JoinTeamEntity toJoinTeamEntity(int teamId, int userId) =>
      JoinTeamEntity(teamId, userId);
}
