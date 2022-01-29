package dev.tpavani.octopoints.db.database

import androidx.room.Database
import androidx.room.RoomDatabase
import dev.tpavani.octopoints.db.dao.JoinTeamDao
import dev.tpavani.octopoints.db.dao.MatchDao
import dev.tpavani.octopoints.db.dao.TeamDao
import dev.tpavani.octopoints.db.dao.UserDao
import dev.tpavani.octopoints.db.entity.JoinTeamEntity
import dev.tpavani.octopoints.db.entity.MatchEntity
import dev.tpavani.octopoints.db.entity.TeamEntity
import dev.tpavani.octopoints.db.entity.UserEntity

@Database(entities = [UserEntity::class, MatchEntity::class, TeamEntity::class, JoinTeamEntity::class], version = 1)
abstract class OctopointsDb : RoomDatabase() {
    abstract fun userDao(): UserDao
    abstract fun matchDao(): MatchDao
    abstract fun teamDao(): TeamDao
    abstract fun joinTeamDao(): JoinTeamDao
}