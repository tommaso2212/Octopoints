import 'package:floor/floor.dart';
import 'package:octopoints/model/UserModel.dart';

class TeamModel {
  int? _id;
  int _matchId;
  int _partial = 0;
  int _total = 0;
  List<UserModel> _users = [];

  TeamModel.insert(this._matchId);
  TeamModel(this._id, this._matchId, this._partial, this._total);

  int? get id => this._id;
  int get matchId => this._matchId;
  int get partial => this._partial;
  int get total => this._total;
  List<UserModel> get users => this._users;

  set partial(int value) => this._partial = value;
  set total(int value) => this._total = value;
  set users(List<UserModel> list) => this._users = list;

  TeamModel setId(int id) {
    this._id = id;
    return this;
  }
}
