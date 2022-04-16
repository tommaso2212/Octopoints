import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/OctopointsProvider.dart';

class UserProvider extends OctopointsProvider<User> {
  @override
  Future<List<User>> getData() {
    return DBService.userService.getUsers();
  }

  void createUser(String username) async {
    create(await DBService.userService.createUser(User(username: username)));
  }

  void deleteUser(User user) async {
    await DBService.userService.deleteUser(user);
    delete(user);
  }
}