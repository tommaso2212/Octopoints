package dev.tpavani.octopoints.db.dao

import androidx.room.Dao
import androidx.room.Query
import dev.tpavani.octopoints.db.entity.UserEntity

@Dao
interface UserDao : IDao<UserEntity> {
    @Query("SELECT * FROM users ORDER BY username")
    suspend fun getAllUsers() : List<UserEntity>
}