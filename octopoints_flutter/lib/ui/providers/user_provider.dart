import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/octopoints_provider.dart';

class UserProvider extends OctopointsProvider<User> {
  @override
  Future<List<User>> getData() async {
    List<User> users = await OctopointsService.userService.getUsers();
    return users;
  }

  void createUser(String username) async {
    User user = await OctopointsService.userService
        .createUser(User(username: username));
    addItem(user);
  }

  void deleteUser(User user) async {
    await OctopointsService.userService.deleteUser(user);
    removeItem(user);
  }
}
