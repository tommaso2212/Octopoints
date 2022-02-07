import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/JoinTeamDao.dart';
import 'package:octopoints_flutter/db/dao/TeamDao.dart';
import 'package:octopoints_flutter/db/entity/JoinTeamEntity.dart';
import 'package:octopoints_flutter/db/entity/TeamEntity.dart';
import 'package:octopoints_flutter/db/entity/UserEntity.dart';
import 'package:octopoints_flutter/service/DBService.dart';
import 'package:octopoints_flutter/service/model/Team.dart';
import 'package:octopoints_flutter/service/model/User.dart';
import 'package:octopoints_flutter/service/utils/GetListFilter.dart';

class DBTeamService extends DBService<Team, TeamEntity> {
  @override
  TeamDao get dao => DbSingleton().db.teamDao;

  final JoinTeamDao _joinTeamDao = DbSingleton().db.joinTeamDao;

  @override
  TeamEntity entityMapper(Team model) {
    return TeamEntity(model.id == 0 ? null : model.id, model.matchId, model.name, model.total, model.partial);
  }

  @override
  Future<List<Team>> getList(GetListFilter filters) async {
    if(filters.id != null){
      List<TeamEntity> list = await dao.getTeamsByMatchId(filters.id!);
      List<Team> teams = list.map((e) => Team(e.matchId, e.name,id: e.id!, total: e.total, partial: e.partial)).toList();
      Iterator iterator = teams.iterator;
      while(iterator.moveNext()){
        Team team = iterator.current;
        List<UserEntity> users = await _joinTeamDao.getTeammates(team.id);
        team.users = users.map((e) => User(e.username, win: e.win, lose: e.lose, id: e.id!)).toList();
      }
      return teams;
    }
    return [];
  }

  Future<void> joinTeam(Team team, User user) async {
    await _joinTeamDao.create(JoinTeamEntity(team.id, user.id));
    team.users.add(user);
  }

  Future<void> leaveTeam(Team team, User user) async {
    await _joinTeamDao.remove(JoinTeamEntity(team.id, user.id));
    team.users.remove(user);
  }

}