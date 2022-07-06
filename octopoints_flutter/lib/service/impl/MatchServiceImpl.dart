import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/MatchDao.dart';
import 'package:octopoints_flutter/db/entity/MatchEntity.dart';
import 'package:octopoints_flutter/service/mapper/MatchMapper.dart';
import 'package:octopoints_flutter/service/service.dart';

class MatchServiceImpl implements MatchService {
  final MatchDao _matchDao = DbSingleton().db.matchDao;

  @override
  Future<Match> createMatch(Match match) async {
    int id = await _matchDao.create(match.toMatchEntity());
    return match.setId(id);
  }
  
  @override
  Future<int> deleteMatch(Match match) {
    return _matchDao.remove(match.toMatchEntity());
  }

  @override
  Future<List<Match>> getMatches({bool archived = false}) async {
    List<Match> matches = [];

    for(MatchEntity entity in await _matchDao.getMatches(archived)){
      Match match = entity.toMatchModel();
      match.rule = await DBService.ruleService.getRuleByMatchId(match.id);
      matches.add(match);
    }

    return matches;
  }

}
