import 'package:octopoints/model/MatchModel.dart';
import 'package:octopoints/model/TeamModel.dart';
import 'package:octopoints/provider/Provider.dart';
import 'package:octopoints/services/TeamService.dart';

class TeamProvider extends Provider<TeamModel> {
  TeamService _service;
  MatchModel _match;
  TeamProvider(this._match, this._service) : super(_service);

  @override
  Future<List<TeamModel>> getAll() => !isAlreadyInit
      ? _service.getAll(byId: _match.id!).then<List<TeamModel>>((list) {
          this.list = list;
          this.isAlreadyInit = true;
          return this.list;
        })
      : Future.value(this.list);
}
