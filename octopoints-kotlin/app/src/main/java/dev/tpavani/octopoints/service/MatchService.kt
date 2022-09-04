package dev.tpavani.octopoints.service

import dev.tpavani.octopoints.service.model.Match

interface MatchService {
    suspend fun createMatch(match: Match): Match
    suspend fun deleteMatch(match: Match)
    suspend fun getMatcher(): List<Match>
}