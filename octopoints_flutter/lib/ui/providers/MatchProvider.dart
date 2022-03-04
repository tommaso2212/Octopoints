import 'package:octopoints_flutter/service/DBService.dart';
import 'package:octopoints_flutter/service/model/Match.dart';
import 'package:octopoints_flutter/ui/providers/OctopointsProvider.dart';

class MatchProvider extends OctopointsProvider<Match> {
  @override
  DBService get service => DBService.matchService;
}
