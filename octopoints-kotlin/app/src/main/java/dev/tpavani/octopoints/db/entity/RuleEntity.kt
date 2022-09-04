package dev.tpavani.octopoints.db.entity

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(
    tableName = "rules",
    foreignKeys = [
        ForeignKey(
            entity = MatchEntity::class,
            parentColumns = ["id"],
            childColumns = ["matchId"],
            onDelete = ForeignKey.CASCADE
        )
    ],
    indices = [
        Index(
            value = ["matchId"],
            unique = true
        ),
    ],
)
class RuleEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    val matchId: Int,
    var winners: Int,
    var total: Int,
    var battleRoyale: Boolean,
)