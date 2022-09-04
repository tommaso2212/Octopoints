package dev.tpavani.octopoints.service.model

class Rule(val matchId: Int, var winners: Int, var total: Int, var battleRoyale: Boolean) {
    private var id: Int? = null

    constructor(id: Int, matchId: Int, winners: Int, total: Int, battleRoyale: Boolean):this(matchId, winners, total, battleRoyale){
        this.id = id
    }

    fun getId(): Int{
        if(this.id == null){
            return 0
        }
        return this.id!!
    }

    fun setId(id: Int): Rule{
        this.id = id
        return this
    }
}