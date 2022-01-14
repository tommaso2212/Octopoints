import 'package:octopoints/model/model.dart';

class MatchManager {
  final MatchModel _matchModel;
  MatchManager(this._matchModel);

  List<TeamModel> _winners = [];
  List<TeamModel> _losers = [];

  List<UserModel> get winners {
    List<UserModel> users = [];
    _winners.forEach((element) => users.addAll(element.users));
    return users;
  }

  List<UserModel> get losers {
    List<UserModel> users = [];
    _losers.forEach((element) => users.addAll(element.users));
    return users;
  }

  bool isGameOver(List<TeamModel> teams) {
    _winners = [];
    _losers = [];
    switch (_matchModel.gamemode) {
      case GameMode.firstToTotal:
        {
          teams.forEach((element) {
            if (element.total >= _matchModel.points) {
              _winners.add(element);
            } else {
              _losers.add(element);
            }
          });
          if (_winners.length >= _matchModel.survivors) return true;
          break;
        }
      case GameMode.lastToTotal:
        {
          teams.forEach((element) {
            if (element.total < _matchModel.points) {
              _winners.add(element);
            } else {
              _losers.add(element);
            }
          });
          if (_winners.length <= _matchModel.survivors) return true;
          break;
        }
      default:
        return false;
    }
    return false;
  }
}
