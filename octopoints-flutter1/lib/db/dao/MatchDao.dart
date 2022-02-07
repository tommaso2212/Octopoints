import 'package:floor/floor.dart';
import 'package:octopoints/db/dao/IDao.dart';
import 'package:octopoints/db/entity/MatchEntity.dart';

@dao
abstract class MatchDao extends IDao<MatchEntity> {
  @Query('SELECT * FROM matches ORDER BY id DESC')
  Future<List<MatchEntity>> getAllMatches();

  @Query('SELECT * FROM matches WHERE id=:id')
  Future<MatchEntity?> getMatchById(int id);

  @Query('DELETE FROM matches WHERE id=:id')
  Future<void> delete(int id);
}
