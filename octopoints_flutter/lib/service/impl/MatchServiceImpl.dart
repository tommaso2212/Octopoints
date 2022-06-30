import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/MatchDao.dart';
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
    return (await _matchDao.getMatches(archived))
        .map((e) => e.toMatchModel())
        .toList();
  }

}
