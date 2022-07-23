import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/database.dart';

@dao
abstract class RuleDao extends IDao<RuleEntity> {
  @Query('SELECT * FROM rules WHERE matchId=:id')
  Future<RuleEntity?> getRule(int id);
}
