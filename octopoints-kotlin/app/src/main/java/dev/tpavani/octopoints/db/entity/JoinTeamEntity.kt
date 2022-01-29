package dev.tpavani.octopoints.db.entity

import androidx.room.Entity
import androidx.room.ForeignKey

@Entity(tableName = "jointeam",
    primaryKeys = ["teamId", "userId"],
    foreignKeys = [
        ForeignKey(
            entity = TeamEntity::class,
            parentColumns = ["id"],
            childColumns = ["teamId"],
            onDelete = ForeignKey.CASCADE,
        ),
        ForeignKey(
            entity = UserEntity::class,
            parentColumns = ["id"],
            childColumns = ["userId"],
            onDelete = ForeignKey.CASCADE,
        )
    ]
)
class JoinTeamEntity(
    val teamId: Int,
    val userId: Int,
)