import 'package:octopoints/model/model.dart';
import 'package:octopoints/model/utils/MatchManager.dart';
import 'package:octopoints/provider/IProvider.dart';
import 'package:octopoints/services/ServiceFactory.dart';

extension MatchProvider on IProvider<TeamModel> {
  static late MatchModel _matchModel;
  static late MatchManager _matchManager;

  void initMatchManager(MatchModel matchModel) {
    _matchModel = matchModel;
    _matchManager = MatchManager(matchModel);
  }

  List<String> get winners =>
      _matchManager.winners.map((e) => e.username).toList();

  Future<void> updateUsersStats() async {
    await ServiceFactory.userService
        .update(_matchManager.winners.map((e) => e.incrementWin()).toList());
    await ServiceFactory.userService
        .update(_matchManager.losers.map((e) => e.incrementLose()).toList());
    ServiceFactory.matchService.delete(_matchModel);
  }

  Future<bool> update(TeamModel team) =>
      ServiceFactory.teamService.update([team]).then<bool>((_) async {
        return _matchManager.isGameOver((await this.getAll()));
      });

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
