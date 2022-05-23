import 'package:octopoints_flutter/service/model/User.dart';

class Team {
  final int id;
  final int matchId;
  int total;
  int partial;
  TeamStatusEnum status;
  List<User> users = [];

  Team({
    this.id = 0,
    required this.matchId,
    this.total = 0,
    this.partial = 0,
    this.status = TeamStatusEnum.playing,
  });
}

enum TeamStatusEnum {
  playing,
  win,
  lose,
}

extension TeamStatusEnumExtension on TeamStatusEnum {
  String get name {
    switch(this){
      case TeamStatusEnum.win: return "Vincitore";
      case TeamStatusEnum.lose: return "Sconfitto";
      case TeamStatusEnum.playing: return "Playing";
    }
  }
}
