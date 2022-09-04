package dev.tpavani.octopoints.db.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import dev.tpavani.octopoints.db.entity.TeamUserRelationEntity
import dev.tpavani.octopoints.db.entity.UserEntity

@Dao
interface TeamUserRelationDao : IDao<TeamUserRelationEntity> {
    @Query("SELECT U.* FROM users U, teamUserRelation J WHERE J.teamId=:teamId AND J.userId=U.id")
    suspend fun getTeammates(teamId: Int): List<UserEntity>

    @Insert
    suspend fun addTeammates(list: List<TeamUserRelationEntity>)

    @Query("DELETE FROM teamUserRelation WHERE teamId=:teamId")
    suspend fun deleteTeammates(teamId: Int)
}