import 'package:octopoints_flutter/service/model/Match.dart';

abstract class MatchService {
  Future<Match> createMatch(Match match);
  Future<int> deleteMatch(Match match);
  Future<List<Match>> getMatches({bool archived = false});
}
