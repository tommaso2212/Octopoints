import 'package:floor_annotation/floor_annotation.dart';
import 'package:octopoints_flutter/db/dao/IDao.dart';
import 'package:octopoints_flutter/db/entity/TeamUserRelation.dart';
import 'package:octopoints_flutter/db/entity/UserEntity.dart';

@dao
abstract class TeamUserRelationDao extends IDao<TeamUserRelation> {
  @Query(
      'SELECT U.* FROM users U, teamUserRelation J WHERE J.teamId=:teamId AND J.userId=U.id')
  Future<List<UserEntity>> getTeammates(int teamId);

  @insert
  Future<List<int>> addTeammates(List<TeamUserRelation> list);
}
