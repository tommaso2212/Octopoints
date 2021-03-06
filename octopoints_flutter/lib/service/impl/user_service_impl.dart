import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/service.dart';

class UserServiceImpl implements UserService {
  final UserDao _userDao = DbSingleton().db.userDao;

  @override
  Future<User> createUser(User user) async {
    int id = await _userDao.create(user.toUserEntity());
    return user.setId(id);
  }

  @override
  Future<int> deleteUser(User user) {
    return _userDao.remove(user.toUserEntity());
  }

  @override
  Future<User> getUserById(int id) async {
    UserEntity? userEntity = await _userDao.getUserById(id);
    return userEntity!.toUserModel();
  }

  @override
  Future<List<User>> getUsers() async {
    return (await _userDao.getAllUsers()).map((e) => e.toUserModel()).toList();
  }

  @override
  Future<int> updateUsers(List<User> users) {
    return _userDao.modify(users.map((e) => e.toUserEntity()).toList());
  }
}
