package dev.tpavani.octopoints.service

import dev.tpavani.octopoints.service.model.Rule

interface RuleService {
    suspend fun createRule(rule: Rule): Rule
    suspend fun deleteRule(rule: Rule)
    suspend fun updateRule(rule: Rule)
    suspend fun getRuleByMatchId(id: Int): Rule?
}