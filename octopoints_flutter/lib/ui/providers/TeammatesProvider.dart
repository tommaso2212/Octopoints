import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/octopoints_provider.dart';

class TeammatesProvider extends OctopointsProvider<User> {
  final Team _team;

  TeammatesProvider(this._team);

  @override
  Future<List<User>> getData() async {
    return Future.value(_team.users);
  }

  void addTeammates(List<User> users) async {
    await OctopointsService.teamService.addTeammates(_team.id, users);
    (await data).addAll(users);
    notifyListeners();
  }

  void leaveTeam(User user) async {
    await OctopointsService.teamService.removeTeammates(_team.id, user.id);
    removeItem(user);
  }
}
