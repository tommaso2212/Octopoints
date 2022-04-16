import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/TeamDao.dart';
import 'package:octopoints_flutter/db/dao/TeamUserRelationDao.dart';
import 'package:octopoints_flutter/db/dao/UserDao.dart';
import 'package:octopoints_flutter/db/entity/TeamUserRelation.dart';
import 'package:octopoints_flutter/service/TeamService.dart';
import 'package:octopoints_flutter/service/model/User.dart';
import 'package:octopoints_flutter/service/model/Team.dart';
import 'package:octopoints_flutter/service/mapper/TeamMapper.dart';
import 'package:octopoints_flutter/service/mapper/UserMapper.dart';
import 'package:octopoints_flutter/service/service.dart';

class TeamServiceImpl implements TeamService {
  final TeamDao _teamDao = DbSingleton().db.teamDao;
  final TeamUserRelationDao _relationDao = DbSingleton().db.teamUserRelationDao;

  @override
  Future<List<int>> addTeammates(int teamId, List<User> users) {
    List<TeamUserRelation> relations = [];
    for (User element in users) {
      relations.add(TeamUserRelation(teamId, element.id));
    }
    return _relationDao.addTeammates(relations);
  }

  @override
  Future<Team> createTeam(Team team) async {
    int id = await _teamDao.create(team.toTeamEntity());
    return team.setId(id);
  }

  @override
  Future<int> deleteTeam(Team team) {
    return _teamDao.remove(team.toTeamEntity());
  }

  Future<List<User>> _getTeammates(int teamId) async {
    return (await _relationDao.getTeammates(teamId))
        .map((e) => e.toUserModel())
        .toList();
  }

  @override
  Future<List<Team>> getTeamsByMatchId(int id) async {
    List<Team> teams = (await _teamDao.getTeamsByMatchId(id))
        .map((e) => e.toTeamModel())
        .toList();
    for (Team team in teams) {
      team.users = await _getTeammates(team.id);
    }
    return teams;
  }

  @override
  Future<int> removeTeammates(int teamId, int userId) {
    return _relationDao.remove(TeamUserRelation(teamId, userId));
  }

  @override
  Future<int> updateTeams(List<Team> teams) {
    return _teamDao.modify(teams.map((e) => e.toTeamEntity()).toList());
  }

  @override
  Future<Map<User, bool>> getAvailableTeammates(Team team) async {
    List<User> users = await DBService.userService.getUsers();
    for (Team item in (await getTeamsByMatchId(team.matchId))) {
      for(User user in item.users){
        users.removeWhere((element) => element.id == user.id);
      }
      
    }
    Map<User, bool> availableUser =
        { for (var e in users) e : false };
    availableUser.addAll({ for (var e in team.users) e : true });
    return availableUser;
  }
}
