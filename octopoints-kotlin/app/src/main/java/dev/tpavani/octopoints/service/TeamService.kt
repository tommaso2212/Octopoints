package dev.tpavani.octopoints.service

import dev.tpavani.octopoints.service.model.Team
import dev.tpavani.octopoints.service.model.User

interface TeamService {
    suspend fun createTeam(team: Team): Team
    suspend fun updateTeams(teams: List<Team>)
    suspend fun deleteTeam(team: Team)
    suspend fun getTeamsByMatchId(id: Int): List<Team>
    suspend fun addTeammates(teamId: Int, users: List<User>)
    suspend fun updateTeammates(team: Team)
    suspend fun getAvailableTeammates(team: Team): Map<User, Boolean>

}