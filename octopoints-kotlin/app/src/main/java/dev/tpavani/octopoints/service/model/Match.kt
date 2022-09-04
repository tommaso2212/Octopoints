package dev.tpavani.octopoints.service.model

class Match(private val name: String) {
    var teams: MutableList<Team> = mutableListOf()
    var rule: Rule? = null
    private var id: Int? = null

    constructor(id: Int, name: String) : this(name) {
        this.id = id
    }

    fun getName(): String {
        return this.name
    }

    fun getId(): Int{
        if(this.id == null){
            return 0
        }
        return this.id!!
    }

    fun setId(id: Int): Match{
        this.id = id
        return this
    }
}

