import 'package:octopoints_flutter/service/model/Rule.dart';
import 'package:octopoints_flutter/service/model/Team.dart';

class Match {
  final int id;
  final String name;
  List<Team> teams = [];
  List<Rule> rules = [];

  Match({
    this.id = 0,
    required this.name
  });
}
