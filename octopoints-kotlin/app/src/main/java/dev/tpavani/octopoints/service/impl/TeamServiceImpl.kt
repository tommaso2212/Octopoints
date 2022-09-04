package dev.tpavani.octopoints.service.impl

import dev.tpavani.octopoints.db.DbSingleton
import dev.tpavani.octopoints.db.entity.TeamUserRelationEntity
import dev.tpavani.octopoints.service.TeamService
import dev.tpavani.octopoints.service.model.Team
import dev.tpavani.octopoints.service.model.User
import dev.tpavani.octopoints.service.utils.ModelMapper
import java.util.*

class TeamServiceImpl: TeamService {
    override suspend fun createTeam(team: Team): Team {
        val id: Int = DbSingleton.getDb().teamDao().create(ModelMapper.toTeamEntity(team))
        return team.setId(id)
    }

    override suspend fun updateTeams(teams: List<Team>) {
        DbSingleton.getDb().teamDao().modify(teams.map { e-> ModelMapper.toTeamEntity(e) })
    }

    override suspend fun deleteTeam(team: Team) {
        DbSingleton.getDb().teamDao().remove(ModelMapper.toTeamEntity(team))
    }

    private suspend fun getTeammates(teamId: Int): List<User>{
        return DbSingleton.getDb().teamUserRelationDao().getTeammates(teamId).map { e-> ModelMapper.toUserModel(e) }
    }

    override suspend fun getTeamsByMatchId(id: Int): List<Team> {
        var teams: MutableList<Team> = mutableListOf()
        for(teamEntity in DbSingleton.getDb().teamDao().getTeamsByMatchId(id)){
            var team: Team = ModelMapper.toTeamModel(teamEntity)
            team.users.addAll(getTeammates(team.getId()))
            teams.add(team)
        }
        return teams
    }

    override suspend fun addTeammates(teamId: Int, users: List<User>) {
        var relations: MutableList<TeamUserRelationEntity> = mutableListOf()
        for (user in users){
            relations.add(TeamUserRelationEntity(teamId, user.getId()))
        }
        DbSingleton.getDb().teamUserRelationDao().addTeammates(relations)
    }

    override suspend fun updateTeammates(team: Team) {
        DbSingleton.getDb().teamUserRelationDao().deleteTeammates(team.getId())
        addTeammates(team.getId(), team.users)
    }

    override suspend fun getAvailableTeammates(team: Team): Map<User, Boolean> {
        var users: MutableList<User> = mutableListOf()
        users.addAll(DbSingleton.getDb().userDao().getAllUsers().map { e-> ModelMapper.toUserModel(e) })
        for(team in getTeamsByMatchId(team.getMatchId())){
            users.removeAll { user-> team.users.map { e-> e.getId() }.contains(user.getId()) }
        }
        var map: SortedMap<User, Boolean> = sortedMapOf(comparator = compareBy{it.getUsername()})

        map.putAll(users.map { e-> e to false }.toMap())
        map.putAll(team.users.map { e-> e to true }.toMap())

        return map
    }
}