package dev.tpavani.octopoints.service.utils

class GetListFilter {
    var id: Int? = null
    var active: Boolean? = null

    fun setId(id: Int): GetListFilter{
        this.id = id
        return this
    }

    fun setActive(active: Boolean): GetListFilter{
        this.active = active
        return this
    }
}