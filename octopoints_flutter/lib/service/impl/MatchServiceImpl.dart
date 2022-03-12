import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/MatchDao.dart';
import 'package:octopoints_flutter/service/MatchService.dart';
import 'package:octopoints_flutter/service/model/Match.dart';
import 'package:octopoints_flutter/service/mapper/MatchMapper.dart';

class MatchServiceImpl implements MatchService {
  final MatchDao _matchDao = DbSingleton().db.matchDao;

  @override
  Future<Match> createMatch(Match match) async {
    int id = await _matchDao.create(match.toMatchEntity());
    return match.setId(id);
  }

  @override
  Future<int> archiveMatch(Match match) {
    match.isActive = false;
    return _matchDao.modify([match.toMatchEntity()]);
  }

  @override
  Future<int> deleteMatch(Match match) {
    return _matchDao.remove(match.toMatchEntity());
  }

  @override
  Future<List<Match>> getMatches(bool active) async {
    return (await _matchDao.getMatches(active))
        .map((e) => e.toMatchModel())
        .toList();
  }
}
