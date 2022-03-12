import 'package:octopoints_flutter/service/MatchService.dart';
import 'package:octopoints_flutter/service/RuleService.dart';
import 'package:octopoints_flutter/service/TeamService.dart';
import 'package:octopoints_flutter/service/UserService.dart';
import 'package:octopoints_flutter/service/impl/MatchServiceImpl.dart';
import 'package:octopoints_flutter/service/impl/RuleServiceImpl.dart';
import 'package:octopoints_flutter/service/impl/TeamServiceImpl.dart';
import 'package:octopoints_flutter/service/impl/UserServiceImpl.dart';

abstract class DBService {
  static final MatchService _matchService = MatchServiceImpl();
  static final UserService _userService = UserServiceImpl();
  static final RuleService _ruleService = RuleServiceImpl();
  static final TeamService _teamService = TeamServiceImpl();

  static MatchService get matchService => _matchService;
  static UserService get userService => _userService;
  static RuleService get ruleService => _ruleService;
  static TeamService get teamService => _teamService;
}
