import 'package:octopoints/db/DbSingleton.dart';
import 'package:octopoints/db/entity/JoinTeamEntity.dart';
import 'package:octopoints/db/utils/EntityConverter.dart';
import 'package:octopoints/model/TeamModel.dart';
import 'package:octopoints/model/UserModel.dart';
import 'package:octopoints/services/IService.dart';

class TeamService implements IService<TeamModel> {
  @override
  Future<TeamModel> create(TeamModel team) async {
    try {
      int id = await DbSingleton()
          .db
          .teamDao
          .create(EntityConverter.toTeamEntity(team));
      return team.setId(id);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(TeamModel team) async {
    try {
      await DbSingleton().db.matchDao.delete(team.id!);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<List<TeamModel>> getAll({int? byId}) async {
    try {
      return await DbSingleton()
          .db
          .teamDao
          .getTeamsByMatchId(byId!)
          .then<List<TeamModel>>(
            (entities) =>
                entities.map((e) => EntityConverter.toTeamModel(e)).toList(),
          );
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> updateTeam(TeamModel team) async {
    try {
      await DbSingleton()
          .db
          .teamDao
          .modify([EntityConverter.toTeamEntity(team)]);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> joinTeam(int teamId, int userId) async {
    try {
      await DbSingleton().db.joinTeamDao.create(JoinTeamEntity(teamId, userId));
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

  Future<List<UserModel>> getTeammates(int teamId) async {
    try {
      return await DbSingleton()
          .db
          .joinTeamDao
          .getTeammates(teamId)
          .then<List<UserModel>>(
            (entities) =>
                entities.map((e) => EntityConverter.toUserModel(e)).toList(),
          );
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> updateUsers(List<UserModel> users) async {
    try {
      await DbSingleton()
          .db
          .userDao
          .modify(users.map((e) => EntityConverter.toUserEntity(e)).toList());
    } on Exception catch (e) {
      throw e;
    }
  }
}
