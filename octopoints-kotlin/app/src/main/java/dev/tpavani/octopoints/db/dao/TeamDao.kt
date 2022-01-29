package dev.tpavani.octopoints.db.dao

import androidx.room.Dao
import androidx.room.Query
import dev.tpavani.octopoints.db.entity.TeamEntity

@Dao
interface TeamDao : IDao<TeamEntity>{
    @Query("SELECT * FROM teams WHERE matchId=:id")
    suspend fun getTeamsByMatchId(id: Int): List<TeamEntity>
}