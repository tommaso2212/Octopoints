import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/service.dart';

class MatchServiceImpl extends OctopointsService implements MatchService {
  @override
  Future<Match> createMatch(Match match) async {
    int id = await db.matchDao.create(match.toMatchEntity());
    return match.setId(id);
  }

  @override
  Future<int> deleteMatch(Match match) {
    return db.matchDao.remove(match.toMatchEntity());
  }

  @override
  Future<List<Match>> getMatches() async {
    List<Match> matches = [];

    for (MatchEntity entity in await db.matchDao.getMatches()) {
      Match match = entity.toMatchModel();
      match.rule =
          await OctopointsService.ruleService.getRuleByMatchId(match.id);
      matches.add(match);
    }

    return matches;
  }
}
