package dev.tpavani.octopoints.service.model

abstract class OctopointsModel {
    private var id: Int = 0

    fun getId(): Int {
        return this.id
    }

    fun setId(id: Int): OctopointsModel {
        this.id = id
        return this
    }
}