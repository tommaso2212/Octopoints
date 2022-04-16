import 'package:floor_annotation/floor_annotation.dart';
import 'package:octopoints_flutter/db/dao/IDao.dart';
import 'package:octopoints_flutter/db/entity/TeamEntity.dart';

@dao
abstract class TeamDao extends IDao<TeamEntity> {
  @Query('SELECT * FROM teams WHERE matchId=:id ORDER BY total DESC')
  Future<List<TeamEntity>> getTeamsByMatchId(int id);
}
