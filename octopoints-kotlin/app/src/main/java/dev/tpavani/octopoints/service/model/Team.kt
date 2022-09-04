package dev.tpavani.octopoints.service.model

class Team(private val matchId: Int){
    private var id: Int? = null
    var total: Int = 0
    var partial: Int = 0
    var status: TeamStatusEnum = TeamStatusEnum.PLAYING
    var users: MutableList<User> = mutableListOf()

    constructor(id: Int, matchId: Int, total: Int, partial: Int, status: TeamStatusEnum): this(matchId) {
        this.id = id
        this.total = total
        this.partial = partial
        this.status = status
    }

    fun getId(): Int{
        if(this.id == null){
            return 0
        }
        return this.id!!
    }

    fun setId(id: Int): Team{
        this.id = id
        return this
    }

    fun getMatchId(): Int {
        return this.matchId
    }

    enum class TeamStatusEnum{
        PLAYING, WIN, LOSE
    }
}