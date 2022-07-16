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

  void createTeam() async {
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
    notifyListeners();
  }

  void sortListByTotal() async {
    (await data).sort(((a, b) => -a.total.compareTo(b.total)));
    notifyListeners();
  }

  void applyRule(Team team) {
    if (_match.rule != null && _match.rule!.total >= team.total) {
      team.status = TeamStatusEnum.win;
    }
  }

  void endGame() {
    if (_match.rule != null &&
        _match.rule!.winners >=
            _match.teams.map((e) => e.status == TeamStatusEnum.win).length) {
      _match.teams.forEach((element) {
        if (element.status == TeamStatusEnum.win) {
          DBService.userService.updateUsers(element.users.map((e) {
            e.addWin();
            return e;
          }).toList());
        } else {
          DBService.userService.updateUsers(element.users.map((e) {
            e.addLose();
            return e;
          }).toList());
        }
      });
    }
  }
}
