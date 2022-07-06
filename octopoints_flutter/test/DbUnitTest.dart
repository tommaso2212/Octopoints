import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/service/DBService.dart';
import 'package:octopoints_flutter/service/MatchService.dart';
import 'package:octopoints_flutter/service/UserService.dart';
import 'package:octopoints_flutter/service/model/User.dart';
import 'package:octopoints_flutter/service/service.dart';

void main() {
  setUpAll(() async {
    await DbSingleton().initDb();
  });

  test('Test user service', () async {
    UserService userService = DBService.userService;
    User user = User(username: "username");
    await userService.createUser(user);
    expect(0, isNot(equals(user.id)));
    user.addWin();
    expect(true, (await userService.updateUsers([user])));
    expect(1, (await userService.getUserById(user.id)).win);
    expect(true, (await userService.deleteUser(user)));
    expect(0, (await userService.getUsers()).length);
  });

  test('Match', () async{
    MatchService matchService = DBService.matchService;
    Match match = await matchService.createMatch(Match(name: "test"));

    expect(0, isNot(equals(match.id)));
  });
}
