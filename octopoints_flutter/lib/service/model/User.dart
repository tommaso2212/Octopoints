import 'package:octopoints_flutter/service/model/OctopointsModel.dart';

class User extends OctopointsModel {
  final String _username;
  late int _win;
  late int _lose;

  User(this._username, {int win = 0, int lose = 0, int id = 0}) : super(id){
    _win = win;
    _lose = lose;
  }

  String get username => _username;
  int get win => _win;
  int get lose => _lose;

  void addWin(){
    _win++;
  }

  void addLose(){
    _lose++;
  }
}