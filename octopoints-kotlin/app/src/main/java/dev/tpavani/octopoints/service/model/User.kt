package dev.tpavani.octopoints.service.model

class User(
    private val username: String,
) {
    private var id: Int = 0
    private var win: Int = 0
    private var lose: Int = 0

    constructor(id: Int, username: String, win: Int, lose: Int) : this(username){
        this.id = id
        this.win = win
        this.lose = lose
    }

    fun getId(): Int {
        return this.id
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

    fun setId(id: Int): User{
        this.id = id
        return this
    }

    fun addWin() {
        this.win++
    }

    fun removeWin(){
        this.win--
    }

    fun addLose() {
        this.lose++
    }

    fun removeLose() {
        this.lose--
    }
}