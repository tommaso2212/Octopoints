import 'package:flutter_test/flutter_test.dart';
import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/service/DBService.dart';
import 'package:octopoints_flutter/service/impl/DBMatchService.dart';
import 'package:octopoints_flutter/service/impl/DBTeamService.dart';
import 'package:octopoints_flutter/service/impl/DBUserService.dart';
import 'package:octopoints_flutter/service/model/Match.dart';
import 'package:octopoints_flutter/service/model/Team.dart';
import 'package:octopoints_flutter/service/model/User.dart';
import 'package:octopoints_flutter/service/utils/GetListFilter.dart';

void main(){
  setUpAll(() async {
    await DbSingleton().initDb();
  });

  test('Test user service', () async {
    DBUserService userService = DBService.userService;
    User user = User("username");
    await userService.create(user);
    expect(0, isNot(equals(user.id)));
    user.addWin();
    expect(true, (await userService.update([user])));
    expect(1, (await userService.getList(GetListFilter().setId(user.id)))[0].win);
    expect(true, (await userService.delete(user)));
    expect(0, (await userService.getList(GetListFilter())).length);
  });

  test('Test match service', () async {
    DBMatchService matchService = DBService.matchService;
    Match match = Match("descrizione", GameMode.FIRST_TO_TOTAL, 1, 1);
    await matchService.create(match);
    expect(0, isNot(equals(match.id)));
    match.isActive = false;
    expect(true, (await matchService.update([match])));
    expect(0, (await matchService.getList(GetListFilter().setIsActive(true))).length);
    expect(true, (await matchService.delete(match)));
  });

  test('Test team service', () async {
    DBMatchService matchService = DBService.matchService;
    Match match = Match("descrizione", GameMode.FIRST_TO_TOTAL, 1, 1);
    await matchService.create(match);

    DBTeamService teamService = DBService.teamService;
    Team team = Team(match.id, "name");
    await teamService.create(team);

    team.total++;
    expect(true, (await teamService.update([team])));

    DBUserService userService = DBService.userService;
    User user = User("username");
    await userService.create(user);

    await teamService.joinTeam(team, user);
    expect(1, (await teamService.getList(GetListFilter().setId(match.id)))[0].users.length);
    await teamService.leaveTeam(team, user);
    expect(0, (await teamService.getList(GetListFilter().setId(match.id)))[0].users.length);

    expect(true, (await teamService.delete(team)));
    await matchService.delete(match);
    await userService.delete(user);
  });
}