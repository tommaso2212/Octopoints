import 'package:octopoints/db/db.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/services/dto/EntityDto.dart';
import 'package:octopoints/services/services.dart';

class UserService implements CRUDService<UserModel> {
  @override
  Future<UserModel> create(UserModel user) async {
    try {
      int id =
          await DbSingleton().db.userDao.create(EntityDto.toUserEntity(user));
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
                entities.map((e) => EntityDto.toUserModel(e)).toList(),
          );
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> update(List<UserModel> users) async {
    try {
      await DbSingleton()
          .db
          .userDao
          .modify(users.map((e) => EntityDto.toUserEntity(e)).toList());
    } on Exception catch (e) {
      throw e;
    }
  }
}
