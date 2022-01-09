import 'package:octopoints/model/model.dart';
import 'package:octopoints/services/interfaces/CRDService.dart';
import 'package:octopoints/services/services.dart';

class ServiceFactory {
  static UserService userService = UserService();
  static MatchService matchService = MatchService();
  static TeamService teamService = TeamService();

  static CRDService getService<T>() {
    switch (T) {
      case MatchModel:
        return matchService;
      case UserModel:
        return userService;
      case TeamModel:
        return teamService;
      default:
        throw Exception('Service type must be declared');
    }
  }
}
