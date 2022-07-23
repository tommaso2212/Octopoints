import 'package:floor_annotation/floor_annotation.dart';
import 'package:octopoints_flutter/db/database.dart';

@dao
abstract class TeamDao extends IDao<TeamEntity> {
  @Query('SELECT * FROM teams WHERE matchId=:id ORDER BY total DESC')
  Future<List<TeamEntity>> getTeamsByMatchId(int id);
}
