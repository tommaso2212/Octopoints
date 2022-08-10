import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/octopoints_provider.dart';

class MatchProvider extends OctopointsProvider<Match> {
  @override
  Future<List<Match>> getData() async {
    List<Match> matches = await OctopointsService.matchService.getMatches();
    return matches;
  }

  void createMatch(String name) async {
    Match match =
        await OctopointsService.matchService.createMatch(Match(name: name));
    addItem(match);
  }

  @override
  void removeItem(Match item) async {
    await OctopointsService.matchService.deleteMatch(item);
    super.removeItem(item);
  }

  Future<Rule> createMatchRule(Match match) async {
    return await OctopointsService.ruleService
        .createRule(Rule(matchId: match.id, winners: 1, total: 3));
  }

  Future updateRule(Match match) async {
    await OctopointsService.ruleService.updateRule(match.rule!);
    updateItem(match);
  }

  void deleteRule(Match match) async {
    await OctopointsService.ruleService.deleteRule(match.rule!);
    match.rule = null;
    updateItem(match);
  }
}
