package dev.tpavani.octopoints.db.dao

import androidx.room.Dao
import androidx.room.Query
import dev.tpavani.octopoints.db.entity.RuleEntity

@Dao
interface RuleDao : IDao<RuleEntity>{
    @Query("SELECT * FROM rules WHERE matchId=:id")
    suspend fun getRule(id: Int): RuleEntity?
}