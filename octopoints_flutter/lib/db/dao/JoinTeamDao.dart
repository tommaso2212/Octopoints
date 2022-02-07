import 'package:floor_annotation/floor_annotation.dart';
import 'package:octopoints_flutter/db/dao/IDao.dart';
import 'package:octopoints_flutter/db/entity/JoinTeamEntity.dart';
import 'package:octopoints_flutter/db/entity/UserEntity.dart';

@dao
abstract class JoinTeamDao extends IDao<JoinTeamEntity> {
  @Query(
      'SELECT U.* FROM users U, jointeam J WHERE J.teamId=:teamId AND J.userId=U.id')
  Future<List<UserEntity>> getTeammates(int teamId);
}
