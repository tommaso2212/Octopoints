import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/OctopointsProvider.dart';

class MatchProvider extends OctopointsProvider<Match> {

  @override
  Future<List<Match>> getData() {
    return DBService.matchService.getMatches(true);
  }

  void createMatch(String name) async {
    create(await DBService.matchService.createMatch(Match(name: name)));
  }

  void deleteMatch(Match match) async {
    await DBService.matchService.deleteMatch(match);
    delete(match);
  }
}
