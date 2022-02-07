package dev.tpavani.octopoints.db.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "users")
class UserEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    val username: String,
    var win: Int,
    var lose: Int,
)