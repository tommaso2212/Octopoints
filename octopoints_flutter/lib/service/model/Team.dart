import 'package:octopoints_flutter/service/model/User.dart';

class Team {
  final int id;
  final int matchId;
  final String name;
  int total;
  int partial;
  TeamStatusEnum status;
  List<User> users = [];

  Team({
    this.id = 0,
    required this.matchId,
    required this.name,
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
