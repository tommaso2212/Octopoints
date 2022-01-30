package dev.tpavani.octopoints.service.model

class Team(private val matchId: Int, private val name: String): OctopointsModel() {
    var total: Int = 0
    var partial: Int = 0
    var users: MutableList<User> = mutableListOf()

    constructor(id: Int, matchId: Int, name: String, total: Int, partial: Int): this(matchId, name) {
        setId(id)
        this.total = total
        this.partial = partial
    }

    fun getMatchId(): Int {
        return this.matchId
    }

    fun getName(): String {
        return this.name
    }
}