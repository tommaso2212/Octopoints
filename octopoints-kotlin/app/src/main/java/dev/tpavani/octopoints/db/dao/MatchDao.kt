package dev.tpavani.octopoints.db.dao

import androidx.room.Dao
import androidx.room.Query
import dev.tpavani.octopoints.db.entity.MatchEntity

@Dao
interface MatchDao : IDao<MatchEntity> {
    @Query("SELECT * FROM matches ORDER BY name")
    suspend fun getMatches(): List<MatchEntity>
}