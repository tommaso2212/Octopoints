import 'dart:collection';

import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/service.dart';

class TeamServiceImpl extends OctopointsService implements TeamService {
  @override
  Future<List<int>> addTeammates(int teamId, List<User> users) {
    List<TeamUserRelationEntity> relations = [];
    for (User element in users) {
      relations.add(TeamUserRelationEntity(teamId, element.id));
    }
    return db.teamUserRelationDao.addTeammates(relations);
  }

  @override
  Future<Team> createTeam(Team team) async {
    int id = await db.teamDao.create(team.toTeamEntity());
    return team.setId(id);
  }

  @override
  Future<int> deleteTeam(Team team) {
    return db.teamDao.remove(team.toTeamEntity());
  }

  Future<List<User>> _getTeammates(int teamId) async {
    return (await db.teamUserRelationDao.getTeammates(teamId))
        .map((e) => e.toUserModel())
        .toList();
  }

  @override
  Future<List<Team>> getTeamsByMatchId(int id) async {
    List<Team> teams = [];

    for (TeamEntity entity in await db.teamDao.getTeamsByMatchId(id)) {
      Team team = entity.toTeamModel();
      team.users = await _getTeammates(team.id);
      teams.add(team);
    }

    return teams;
  }

  @override
  Future<int> updateTeams(List<Team> teams) {
    return db.teamDao.modify(teams.map((e) => e.toTeamEntity()).toList());
  }

  @override
  Future<Map<User, bool>> getAvailableTeammates(Team team) async {
    List<User> users = await OctopointsService.userService.getUsers();
    for (Team item in (await getTeamsByMatchId(team.matchId))) {
      for (User user in item.users) {
        users.removeWhere((element) => element.id == user.id);
      }
    }
    SplayTreeMap<User, bool> availableUser = SplayTreeMap(
      (user1, user2) => user1.username.compareTo(user2.username),
    );
    availableUser.addAll({for (var e in users) e: false});
    availableUser.addAll({for (var e in team.users) e: true});
    return availableUser;
  }

  @override
  Future<List<int>> updateTeammates(Team team) async {
    await db.teamUserRelationDao.deleteTeammates(team.id);
    return addTeammates(team.id, team.users);
  }
}
