import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/match_service.dart';
import 'package:octopoints_flutter/service/rule_service.dart';
import 'package:octopoints_flutter/service/team_service.dart';
import 'package:octopoints_flutter/service/user_service.dart';
import 'package:octopoints_flutter/service/impl/match_service_impl.dart';
import 'package:octopoints_flutter/service/impl/rule_service_impl.dart';
import 'package:octopoints_flutter/service/impl/team_service_impl.dart';
import 'package:octopoints_flutter/service/impl/user_service_impl.dart';

abstract class OctopointsService {
  OctopointsDb get db => DbSingleton().db;

  static final MatchService _matchService = MatchServiceImpl();
  static final UserService _userService = UserServiceImpl();
  static final RuleService _ruleService = RuleServiceImpl();
  static final TeamService _teamService = TeamServiceImpl();

  static MatchService get matchService => _matchService;
  static UserService get userService => _userService;
  static RuleService get ruleService => _ruleService;
  static TeamService get teamService => _teamService;
}
