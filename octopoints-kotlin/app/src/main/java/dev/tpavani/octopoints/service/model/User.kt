package dev.tpavani.octopoints.service.model

class User(
    private val username: String,
): OctopointsModel() {
    private var win: Int = 0
    private var lose: Int = 0

    constructor(id: Int, username: String, win: Int, lose: Int) : this(username){
        setId(id)
        this.win = win
        this.lose = lose
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