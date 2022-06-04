import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/OctopointsProvider.dart';

class TeamProvider extends OctopointsProvider<Team> {
  final Match _match;

  TeamProvider(this._match);

  @override
  Future<List<Team>> getData() async {
    return DBService.teamService.getTeamsByMatchId(_match.id);
    
  }

  void createTeam(String name) async {
    create(await DBService.teamService.createTeam(Team(matchId: _match.id)));
  }

  void deleteTeam(Team team) async {
    await DBService.teamService.deleteTeam(team);
    delete(team);
  }

  void updateTeam(Team teamToUpdate) async {
    await DBService.teamService.updateTeams([teamToUpdate]);
    (await data)[(await data)
        .indexWhere((Team team) => team.id == teamToUpdate.id)] = teamToUpdate;
    (await data).sort(((a, b) => -a.total.compareTo(b.total)));
    notifyListeners();
  }

  void endGame(){

  }
}
