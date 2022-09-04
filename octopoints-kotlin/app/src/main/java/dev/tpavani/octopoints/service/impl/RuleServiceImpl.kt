package dev.tpavani.octopoints.service.impl

import dev.tpavani.octopoints.db.DbSingleton
import dev.tpavani.octopoints.service.RuleService
import dev.tpavani.octopoints.service.model.Rule
import dev.tpavani.octopoints.service.utils.ModelMapper

class RuleServiceImpl : RuleService {
    override suspend fun createRule(rule: Rule): Rule {
        var id: Int = DbSingleton.getDb().ruleDao().create(ModelMapper.toRuleEntity(rule))
        return rule.setId(id)
    }

    override suspend fun deleteRule(rule: Rule) {
        DbSingleton.getDb().ruleDao().remove(ModelMapper.toRuleEntity(rule))
    }

    override suspend fun updateRule(rule: Rule) {
        DbSingleton.getDb().ruleDao().modify(mutableListOf(ModelMapper.toRuleEntity(rule)))
    }

    override suspend fun getRuleByMatchId(id: Int): Rule? {
        return ModelMapper.toRuleModel(DbSingleton.getDb().ruleDao().getRule(id))
    }
}