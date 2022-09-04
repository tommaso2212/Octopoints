package dev.tpavani.octopoints.service.model

class User(
    private val username: String,
){
    private var id: Int? = null
    private var win: Int = 0
    private var lose: Int = 0

    constructor(id: Int, username: String, win: Int, lose: Int) : this(username){
        this.win = win
        this.lose = lose
    }

    fun getId(): Int{
        if(this.id == null){
            return 0
        }
        return this.id!!
    }

    fun setId(id: Int): User{
        this.id = id
        return this
    }

    fun getUsername(): String {
        return this.username
    }

    fun getWin(): Int {
        return this.win
    }

    fun getLose(): Int {
        return this.lose
    }

    fun addWin(): User {
        this.win++
        return this
    }

    fun addLose(): User {
        this.lose++
        return this
    }
}