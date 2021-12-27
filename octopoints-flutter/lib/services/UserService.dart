import 'package:octopoints/db/DbSingleton.dart';
import 'package:octopoints/db/utils/EntityConverter.dart';
import 'package:octopoints/model/UserModel.dart';
import 'package:octopoints/services/IService.dart';

class UserService implements IService<UserModel> {
  @override
  Future<UserModel> create(UserModel user) async {
    try {
      int id = await DbSingleton()
          .db
          .userDao
          .create(EntityConverter.toUserEntity(user));
      return user.setId(id);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(UserModel user) async {
    try {
      await DbSingleton().db.userDao.delete(user.id!);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<List<UserModel>> getAll({int? byId}) async {
    try {
      return await DbSingleton().db.userDao.getAllUsers().then<List<UserModel>>(
            (entities) =>
                entities.map((e) => EntityConverter.toUserModel(e)).toList(),
          );
    } on Exception catch (e) {
      throw e;
    }
  }
}
