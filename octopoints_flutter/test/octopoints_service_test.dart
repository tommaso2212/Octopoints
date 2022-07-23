
import 'package:flutter_test/flutter_test.dart';
import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/service.dart';

void main() {

  setUpAll(() async {
    await DbSingleton().initInMemoryDb();
  });

  test('Test user service', () async {
    UserService userService = OctopointsService.userService;
    User user = User(username: "username");
    user = await userService.createUser(user);
    expect(0, isNot(equals(user.id)));
    user.addWin();
    await userService.updateUsers([user]);
    expect(1, (await userService.getUserById(user.id)).win);

    List<User> users = await userService.getUsers();
    for (var element in users) {userService.deleteUser(element);}

    expect(0, (await userService.getUsers()).length);
  });

  test('Match', () async{
    MatchService matchService = OctopointsService.matchService;
    Match match = await matchService.createMatch(Match(name: "test"));
    expect(0, isNot(equals(match.id)));


  });
}
