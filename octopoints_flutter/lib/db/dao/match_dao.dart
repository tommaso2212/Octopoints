import 'package:floor_annotation/floor_annotation.dart';
import 'package:octopoints_flutter/db/database.dart';

@dao
abstract class MatchDao extends IDao<MatchEntity> {
  @Query('SELECT * FROM matches WHERE archived = :archived ORDER BY name')
  Future<List<MatchEntity>> getMatches(bool archived);
}
