import 'package:floor/floor.dart';
import 'package:octopoints/db/dao/IDao.dart';
import 'package:octopoints/db/entity/TeamEntity.dart';

@dao
abstract class TeamDao extends IDao<TeamEntity> {
  @Query('SELECT * FROM teams WHERE matchId=:id')
  Future<List<TeamEntity>> getTeamsByMatchId(int id);

  @Query('SELECT * FROM teams WHERE teamId=:id')
  Future<TeamEntity?> getTeamById(int id);

  @Query('DELETE FROM teams WHERE id=:id')
  Future<void> delete(int id);
}
