package dev.tpavani.octopoints.db.dao

import androidx.room.Dao
import androidx.room.Query
import dev.tpavani.octopoints.db.entity.MatchEntity

@Dao
interface MatchDao : IDao<MatchEntity> {
    @Query("SELECT * FROM matches WHERE active=:active ORDER BY id DESC")
    suspend fun getMatches(active: Boolean?): List<MatchEntity>
}