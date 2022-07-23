import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/octopoints_provider.dart';

class UserProvider extends OctopointsProvider<User> {
  @override
  Future<List<User>> getData() {
    return OctopointsService.userService.getUsers();
  }

  void createUser(String username) async {
    create(await OctopointsService.userService.createUser(User(username: username)));
  }

  void deleteUser(User user) async {
    await OctopointsService.userService.deleteUser(user);
    delete(user);
  }
}