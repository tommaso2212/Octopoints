package dev.tpavani.octopoints.service.impl

import dev.tpavani.octopoints.db.DbSingleton
import dev.tpavani.octopoints.db.dao.MatchDao
import dev.tpavani.octopoints.db.entity.matchEntity
import dev.tpavani.octopoints.service.DBService
import dev.tpavani.octopoints.service.model.Match
import dev.tpavani.octopoints.service.utils.GetListFilter

class DBMatchService: DBService<Match, matchEntity>() {

    override val dao: MatchDao = DbSingleton.getDb().matchDao()

    override fun entityMapper(model: Match): matchEntity {
        return matchEntity(model.getId(), model.getDescription(), model.getGameMode().ordinal, model.getPoints(), model.getSurvivors(), model.isActive())
    }

    override suspend fun getList(filter: GetListFilter): MutableList<Match> {
        if (filter.active != null){
            return dao.getMatches(filter.active!!).map { Match(it.id, it.description, Match.GameMode.values()[it.gameMode], it.points, it.survivors, it.active) }.toMutableList()
        }
        return mutableListOf()
    }
}