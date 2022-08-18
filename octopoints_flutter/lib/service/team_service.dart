import 'package:octopoints_flutter/service/service.dart';

abstract class TeamService {
  Future<Team> createTeam(Team team);
  Future<int> updateTeams(List<Team> teams);
  Future<int> deleteTeam(Team team);
  Future<List<Team>> getTeamsByMatchId(int id);
  Future<List<int>> addTeammates(int teamId, List<User> users);
  Future<Map<User, bool>> getAvailableTeammates(Team team);
  Future<List<int>> updateTeammates(Team team);
}
