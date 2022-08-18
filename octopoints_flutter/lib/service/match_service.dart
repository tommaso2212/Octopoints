import 'package:octopoints_flutter/service/service.dart';

abstract class MatchService {
  Future<Match> createMatch(Match match);
  Future<int> deleteMatch(Match match);
  Future<List<Match>> getMatches();
}
