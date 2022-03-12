import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/dao/IDao.dart';
import 'package:octopoints_flutter/db/entity/RuleEntity.dart';

@dao
abstract class RuleDao extends IDao<RuleEntity> {
  @Query('SELECT * FROM rules WHERE matchId=:id')
  Future<List<RuleEntity>> getRules(int id);
}
