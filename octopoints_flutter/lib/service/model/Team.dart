import 'package:octopoints_flutter/service/model/OctopointsModel.dart';
import 'package:octopoints_flutter/service/model/User.dart';

class Team extends OctopointsModel {
  final int _matchId;
  final String _name;
  int total;
  int partial;
  List<User> users = [];

  Team(this._matchId, this._name, {this.total = 0, this.partial = 0, int id = 0}) : super(id);

  int get matchId => _matchId;
  String get name => _name;

}
