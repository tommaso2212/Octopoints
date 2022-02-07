import 'package:floor_annotation/floor_annotation.dart';
import 'package:octopoints_flutter/db/dao/IDao.dart';
import 'package:octopoints_flutter/db/entity/UserEntity.dart';

@dao
abstract class UserDao extends IDao<UserEntity> {
  @Query('SELECT * FROM users ORDER BY username')
  Future<List<UserEntity>> getAllUsers();

  @Query('SELECT * FROM users WHERE id=:id')
  Future<UserEntity?> getUserById(int id);
}
