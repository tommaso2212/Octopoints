import 'package:floor_annotation/floor_annotation.dart';
import 'package:octopoints_flutter/db/dao/IDao.dart';
import 'package:octopoints_flutter/db/entity/MatchEntity.dart';

@dao
abstract class MatchDao extends IDao<MatchEntity> {
  @Query('SELECT * FROM matches WHERE isActive=:active ORDER BY id DESC')
  Future<List<MatchEntity>> getMatches(bool active);
}
