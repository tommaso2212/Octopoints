import 'package:octopoints_flutter/service/service.dart';

class Match{
  final int id;
  final String name;
  bool archived;
  List<Team> teams = [];
  Rule? rule;

  Match({
    this.id = 0,
    required this.name,
    this.archived = false
  });
}
