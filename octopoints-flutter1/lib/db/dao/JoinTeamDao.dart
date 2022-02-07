import 'package:floor/floor.dart';
import 'package:octopoints/db/dao/IDao.dart';
import 'package:octopoints/db/entity/JoinTeamEntity.dart';
import 'package:octopoints/db/entity/UserEntity.dart';

@dao
abstract class JoinTeamDao extends IDao<JoinTeamEntity> {
  @Query('DELETE FROM jointeam WHERE teamId=:teamId AND userId=:userId')
  Future<void> leaveTeam(int teamId, int userId);

  @Query(
      'SELECT U.* FROM users U, jointeam J WHERE J.teamId=:teamId AND J.userId=U.id')
  Future<List<UserEntity>> getTeammates(int teamId);
}
