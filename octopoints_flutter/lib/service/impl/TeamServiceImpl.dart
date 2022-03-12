import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/TeamDao.dart';
import 'package:octopoints_flutter/db/dao/TeamUserRelationDao.dart';
import 'package:octopoints_flutter/db/entity/TeamUserRelation.dart';
import 'package:octopoints_flutter/service/TeamService.dart';
import 'package:octopoints_flutter/service/model/User.dart';
import 'package:octopoints_flutter/service/model/Team.dart';
import 'package:octopoints_flutter/service/mapper/TeamMapper.dart';
import 'package:octopoints_flutter/service/mapper/UserMapper.dart';

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

  @override
  Future<List<User>> getTeammates(int teamId) async {
    return (await _relationDao.getTeammates(teamId))
        .map((e) => e.toUserModel())
        .toList();
  }

  @override
  Future<List<Team>> getTeamsByMatchId(int id) async {
    return (await _teamDao.getTeamsByMatchId(id))
        .map((e) => e.toTeamModel())
        .toList();
  }

  @override
  Future<int> removeTeammates(int teamId, int userId) {
    return _relationDao.remove(TeamUserRelation(teamId, userId));
  }

  @override
  Future<int> updateTeams(List<Team> teams) {
    return _teamDao.modify(teams.map((e) => e.toTeamEntity()).toList());
  }
}
