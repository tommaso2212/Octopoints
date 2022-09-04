package dev.tpavani.octopoints.db.dao

import androidx.room.Dao
import androidx.room.Query
import dev.tpavani.octopoints.db.entity.JoinTeamEntity
import dev.tpavani.octopoints.db.entity.UserEntity

@Dao
interface JoinTeamDao : IDao<JoinTeamEntity> {
    @Query("SELECT U.* FROM users U, jointeam J WHERE J.teamId=:teamId AND J.userId=U.id")
    suspend fun getTeammates(teamId: Int): List<UserEntity>
}