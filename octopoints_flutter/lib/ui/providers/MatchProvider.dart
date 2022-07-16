import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/OctopointsProvider.dart';

class MatchProvider extends OctopointsProvider<Match> {
  @override
  Future<List<Match>> getData() {
    return DBService.matchService.getMatches();
  }

  void createMatch(String name) async {
    create(await DBService.matchService.createMatch(Match(name: name)));
  }

  void deleteMatch(Match match) async {
    await DBService.matchService.deleteMatch(match);
    delete(match);
  }

  Future createMatchRule(Match match) async {
    Rule rule = await DBService.ruleService
        .createRule(Rule(matchId: match.id, winners: 1, total: 3));
    match.rule = rule;
    //notifyListeners();
  }
}
