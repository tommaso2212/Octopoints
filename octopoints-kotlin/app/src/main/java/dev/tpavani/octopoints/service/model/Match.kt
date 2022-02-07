package dev.tpavani.octopoints.service.model

class Match(private val description: String, private var gameMode: GameMode, private var points: Int, private var survivors: Int):
    OctopointsModel() {
    private var active: Boolean = true
    var teams: MutableList<Team> = mutableListOf()

    constructor(id: Int, description: String, gameMode: GameMode, points: Int, survivors: Int, active: Boolean) : this(description, gameMode, points, survivors) {
        setId(id)
        this.gameMode = gameMode
        this.points = points
        this.survivors = survivors
        this.active = active
    }

    fun getDescription(): String {
        return this.description
    }

    fun getGameMode(): GameMode {
        return this.gameMode
    }

    fun getPoints(): Int {
        return this.points
    }

    fun getSurvivors(): Int {
        return this.survivors
    }

    fun isActive(): Boolean {
        return this.active
    }

    fun archiveMatch(): Match {
        this.active = false
        return this
    }

    enum class GameMode {
        FIRST_TO_TOTAL,
        LAST_TO_TOTAL
    }
}

