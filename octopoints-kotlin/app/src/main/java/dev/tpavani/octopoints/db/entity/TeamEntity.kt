package dev.tpavani.octopoints.db.entity

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

@Entity(tableName = "teams", foreignKeys = [
    ForeignKey(
        entity = MatchEntity::class,
        parentColumns = ["id"],
        childColumns = ["matchId"],
        onDelete = ForeignKey.CASCADE
    )
])
class TeamEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val matchId: Int,
    val name: String,
    var total: Int = 0,
    var partial: Int = 0,
)