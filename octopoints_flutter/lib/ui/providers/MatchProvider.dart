import 'package:octopoints_flutter/service/model/rule.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/octopoints_provider.dart';

class MatchProvider extends OctopointsProvider<Match> {
  @override
  Future<List<Match>> getData() {
    return OctopointsService.matchService.getMatches();
  }

  void createMatch(String name) async {
    create(await OctopointsService.matchService.createMatch(Match(name: name)));
  }

  void deleteMatch(Match match) async {
    await OctopointsService.matchService.deleteMatch(match);
    delete(match);
  }

  Future createMatchRule(Match match) async {
    Rule rule = await OctopointsService.ruleService
        .createRule(Rule(matchId: match.id, winners: 1, total: 3));
    match.rule = rule;
    //notifyListeners();
  }
}
