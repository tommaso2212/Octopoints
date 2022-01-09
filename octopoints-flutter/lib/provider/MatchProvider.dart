import 'package:octopoints/model/model.dart';
import 'package:octopoints/provider/IProvider.dart';
import 'package:octopoints/services/ServiceFactory.dart';

extension MatchProvider on IProvider<TeamModel> {
  Future<void> update(TeamModel team) =>
      ServiceFactory.teamService.update([team]);

  void leaveTeam(int teamId, int userId) =>
      ServiceFactory.teamService.leaveTeam(teamId, userId).then((_) async {
        List<UserModel> users = (await this.getAll())
            .firstWhere((element) => element.id == teamId)
            .users;
        users.removeWhere((element) => element.id == userId);
        notifyListeners();
      });

  void joinTeam(int teamId, UserModel userModel) => ServiceFactory.teamService
          .joinTeam(teamId, userModel.id!)
          .then((_) async {
        List<UserModel> users = (await this.getAll())
            .firstWhere((element) => element.id == teamId)
            .users;
        users.add(userModel);
        notifyListeners();
      });

  Future<List<UserModel>> availableUsers() =>
      ServiceFactory.userService.getAll().then<List<UserModel>>((value) async {
        List<TeamModel> teams = (await this.getAll());
        teams.forEach((team) {
          team.users.forEach((user) {
            value.removeWhere((element) => element.id == user.id);
          });
        });
        return value;
      });
}
