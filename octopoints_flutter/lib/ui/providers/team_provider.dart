import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/octopoints_provider.dart';

class TeamProvider extends OctopointsProvider<Team> {
  final Match _match;

  TeamProvider(this._match);

  @override
  Future<List<Team>> getData() async {
    List<Team> teams =
        await OctopointsService.teamService.getTeamsByMatchId(_match.id);
    return teams;
  }

  void createTeam() async {
    Team team = await OctopointsService.teamService
        .createTeam(Team(matchId: _match.id));
    addItem(team);
  }

  void deleteTeam(Team team) async {
    await OctopointsService.teamService.deleteTeam(team);
    removeItem(team);
  }

  void updateTeam(Team team) async {
    updateTeamStatusByRule(team);
    await OctopointsService.teamService.updateTeams([team]);
    updateItem(team);
  }

  void sortListByTotal() async {
    forceUpdateListData();
    notifyListeners();
  }

  void updateTeammates(Team team) async {
    await OctopointsService.teamService.updateTeammates(team);
    updateItem(team);
  }

  void updateTeamStatusByRule(Team team) {
    if (_match.rule != null && team.total >= _match.rule!.total) {
      team.status = TeamStatusEnum.win;
    } else {
      team.status = TeamStatusEnum.playing;
    }
  }

  List<Team> _getWinners() {
    return data.where((team) => TeamStatusEnum.win == team.status).toList();
  }

  List<User> getWinningUsers() {
    List<User> users = [];
    for (var team in _getWinners()) {
      users.addAll(team.users);
    }
    return users;
  }

  bool endMatch() {
    return _match.rule != null && _getWinners().length >= _match.rule!.winners;
  }

  void updateUsers() async {
    List<User> users = [];
    for (Team team in data) {
      if (_getWinners().contains(team)) {
        users.addAll(team.users.map((e) => e.addWin()));
      } else {
        users.addAll(team.users.map((e) => e.addLose()));
      }
    }
    await OctopointsService.userService.updateUsers(users);
  }

  void deleteMatch() async {
    await OctopointsService.matchService.deleteMatch(_match);
    updateUsers();
  }
}
