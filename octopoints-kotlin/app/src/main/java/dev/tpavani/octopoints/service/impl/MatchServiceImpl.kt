package dev.tpavani.octopoints.service.impl

import dev.tpavani.octopoints.db.DbSingleton
import dev.tpavani.octopoints.db.entity.MatchEntity
import dev.tpavani.octopoints.service.MatchService
import dev.tpavani.octopoints.service.model.Match
import dev.tpavani.octopoints.service.utils.ModelMapper

class MatchServiceImpl: MatchService {
    override suspend fun createMatch(match: Match): Match {
        var id: Int = DbSingleton.getDb().matchDao().create(ModelMapper.toMatchEntity(match))
        return match.setId(id)
    }

    override suspend fun deleteMatch(match: Match) {
        DbSingleton.getDb().matchDao().remove(ModelMapper.toMatchEntity(match))
    }

    override suspend fun getMatcher(): List<Match> {
        var list: MutableList<Match> = mutableListOf()
        for (matchEntity in DbSingleton.getDb().matchDao().getMatches()){
            var match = ModelMapper.toMatchModel(matchEntity)
            match.rule = ModelMapper.toRuleModel(DbSingleton.getDb().ruleDao().getRule(match.getId()))
            list.add(match)
        }
        return list
    }
}