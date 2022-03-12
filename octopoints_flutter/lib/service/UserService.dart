import 'package:octopoints_flutter/service/model/User.dart';

abstract class UserService {
  Future<User> createUser(User user);
  Future<int> updateUsers(List<User> users);
  Future<int> deleteUser(User user);
  Future<List<User>> getUsers();
  Future<User> getUserById(int id);
}
