package dev.tpavani.octopoints.db.database

import androidx.room.Database
import androidx.room.RoomDatabase
import dev.tpavani.octopoints.db.dao.*
import dev.tpavani.octopoints.db.entity.MatchEntity
import dev.tpavani.octopoints.db.entity.TeamEntity
import dev.tpavani.octopoints.db.entity.TeamUserRelationEntity
import dev.tpavani.octopoints.db.entity.UserEntity

@Database(entities = [UserEntity::class, MatchEntity::class, TeamEntity::class, TeamUserRelationEntity::class], version = 1)
abstract class OctopointsDb : RoomDatabase() {
    abstract fun userDao(): UserDao
    abstract fun matchDao(): MatchDao
    abstract fun teamDao(): TeamDao
    abstract fun teamUserRelationDao(): TeamUserRelationDao
    abstract fun ruleDao(): RuleDao
}