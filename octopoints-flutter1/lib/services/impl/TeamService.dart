import 'package:octopoints/db/db.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/services/dto/EntityDto.dart';
import 'package:octopoints/services/interfaces/CRUDService.dart';

class TeamService implements CRUDService<TeamModel> {
  @override
  Future<TeamModel> create(TeamModel team) async {
    try {
      int id =
          await DbSingleton().db.teamDao.create(EntityDto.toTeamEntity(team));
      return team.setId(id);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(TeamModel team) async {
    try {
      await DbSingleton().db.teamDao.delete(team.id!);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<List<TeamModel>> getAll({int? byId}) async {
    try {
      List<TeamModel> list = await DbSingleton()
          .db
          .teamDao
          .getTeamsByMatchId(byId!)
          .then<List<TeamModel>>((entities) =>
              entities.map((e) => EntityDto.toTeamModel(e)).toList());
      for (TeamModel team in list) team.users = await _getTeammates(team.id!);
      return list;
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> update(List<TeamModel> teams) async {
    try {
      await DbSingleton()
          .db
          .teamDao
          .modify(teams.map((e) => EntityDto.toTeamEntity(e)).toList());
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<UserModel>> _getTeammates(int teamId) async {
    try {
      return await DbSingleton()
          .db
          .joinTeamDao
          .getTeammates(teamId)
          .then<List<UserModel>>(
            (entities) =>
                entities.map((e) => EntityDto.toUserModel(e)).toList(),
          );
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> joinTeam(int teamId, int userId) async {
    try {
      await DbSingleton()
          .db
          .joinTeamDao
          .create(EntityDto.toJoinTeamEntity(teamId, userId));
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> leaveTeam(int teamId, int userId) async {
    try {
      await DbSingleton().db.joinTeamDao.leaveTeam(teamId, userId);
    } on Exception catch (e) {
      throw e;
    }
  }
}
