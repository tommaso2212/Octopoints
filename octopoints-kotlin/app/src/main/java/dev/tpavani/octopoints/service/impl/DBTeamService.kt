package dev.tpavani.octopoints.service.impl

import dev.tpavani.octopoints.db.DbSingleton
import dev.tpavani.octopoints.db.dao.JoinTeamDao
import dev.tpavani.octopoints.db.dao.TeamDao
import dev.tpavani.octopoints.db.entity.JoinTeamEntity
import dev.tpavani.octopoints.db.entity.TeamEntity
import dev.tpavani.octopoints.service.DBService
import dev.tpavani.octopoints.service.model.Team
import dev.tpavani.octopoints.service.model.User
import dev.tpavani.octopoints.service.utils.GetListFilter
import java.util.function.Predicate

class DBTeamService: DBService<Team, TeamEntity>() {

    override val dao: TeamDao = DbSingleton.getDb().teamDao()
    private val joinTeamDao: JoinTeamDao = DbSingleton.getDb().joinTeamDao()

    override fun entityMapper(model: Team): TeamEntity {
        return TeamEntity(model.getId(), model.getMatchId(), model.getName(), model.total, model.partial)
    }

    override suspend fun getList(filter: GetListFilter): MutableList<Team> {
        if(filter.id != null){
            val list = dao.getTeamsByMatchId(filter.id!!).map { Team(it.id, it.matchId, it.name, it.total, it.partial) }.toMutableList()
            val iterator: Iterator<Team> = list.iterator()
            while (iterator.hasNext()){
                var team = iterator.next()
                team.users = joinTeamDao.getTeammates(team.getId()).map { User(it.id, it.username, it.win, it.lose) }.toMutableList()
            }
            return list
        }
        return mutableListOf()
    }

    suspend fun joinTeam(team: Team, user: User) {
        joinTeamDao.create(JoinTeamEntity(team.getId(), user.getId()))
        team.users.add(user)
    }

    suspend fun leaveTeam(team: Team, user: User) {
        joinTeamDao.remove(JoinTeamEntity(team.getId(), user.getId()))
        team.users.remove(user)
    }
}