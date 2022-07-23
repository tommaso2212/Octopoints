import 'package:floor_annotation/floor_annotation.dart';
import 'package:octopoints_flutter/db/database.dart';

@dao
abstract class TeamUserRelationDao extends IDao<TeamUserRelationEntity> {
  @Query(
      'SELECT U.* FROM users U, teamUserRelation J WHERE J.teamId=:teamId AND J.userId=U.id')
  Future<List<UserEntity>> getTeammates(int teamId);

  @insert
  Future<List<int>> addTeammates(List<TeamUserRelationEntity> list);
}
