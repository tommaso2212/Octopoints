import 'package:floor/floor.dart';
import 'package:octopoints/db/dao/IDao.dart';
import 'package:octopoints/db/entity/UserEntity.dart';

@dao
abstract class UserDao extends IDao<UserEntity> {
  @Query('SELECT * FROM users ORDER BY username')
  Future<List<UserEntity>> getAllUsers();

  @Query('SELECT * FROM users WHERE id=:id')
  Future<UserEntity?> getUserById(int id);

  @Query('DELETE FROM users WHERE id=:id')
  Future<void> delete(int id);
}
