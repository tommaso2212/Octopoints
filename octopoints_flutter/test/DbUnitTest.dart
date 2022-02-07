import 'package:flutter_test/flutter_test.dart';
import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/service/DBService.dart';
import 'package:octopoints_flutter/service/impl/DBUserService.dart';
import 'package:octopoints_flutter/service/model/User.dart';
import 'package:octopoints_flutter/service/utils/GetListFilter.dart';

void main(){
  setUpAll(() async {
    await DbSingleton().initDb();
  });

  test('Test user db', () async {
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
}