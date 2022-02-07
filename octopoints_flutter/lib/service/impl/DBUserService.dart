import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/UserDao.dart';
import 'package:octopoints_flutter/db/entity/UserEntity.dart';
import 'package:octopoints_flutter/service/DBService.dart';
import 'package:octopoints_flutter/service/model/User.dart';
import 'package:octopoints_flutter/service/utils/GetListFilter.dart';

class DBUserService extends DBService<User, UserEntity>{
  @override
  UserDao get dao => DbSingleton().db.userDao;

  @override
  UserEntity entityMapper(User model) {
    return UserEntity(model.id == 0 ? null : model.id, model.username, model.win, model.lose);
  }

  @override
  Future<List<User>> getList(GetListFilter filters) async {
    if(filters.id != null){
      UserEntity? userEntity = await (dao).getUserById(filters.id!);
      if(userEntity != null){
        return [User(userEntity.username, id: userEntity.id!, win: userEntity.win, lose: userEntity.lose)];
      }
    } else {
      return (await (dao).getAllUsers()).map((userEntity) => User(userEntity.username, id: userEntity.id!, win: userEntity.win, lose: userEntity.lose)).toList();
    }
    return [];
  }

}