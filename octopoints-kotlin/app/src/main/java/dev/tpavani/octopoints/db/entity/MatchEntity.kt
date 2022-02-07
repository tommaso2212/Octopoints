package dev.tpavani.octopoints.db.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "matches")
class MatchEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    val description: String,
    val gameMode: Int,
    val points: Int,
    val survivors: Int,
    var active: Boolean,
)