import 'package:octopoints_flutter/service/model/OctopointsModel.dart';
import 'package:octopoints_flutter/service/model/Team.dart';

class Match extends OctopointsModel {
  final String _description;
  final GameMode _gameMode;
  final int _points;
  final int _survivors;
  bool isActive;
  List<Team> teams = [];

  Match(this._description, this._gameMode, this._points, this._survivors, {this.isActive = true, int id = 0}) : super(id);

  String get description => _description;
  GameMode get gameMode => _gameMode;
  int get points => _points;
  int get survivors => _survivors;

}

enum GameMode {
  FIRST_TO_TOTAL,
  LAST_TO_TOTAL
}
