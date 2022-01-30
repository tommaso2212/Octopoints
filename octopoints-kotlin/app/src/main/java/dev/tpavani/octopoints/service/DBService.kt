package dev.tpavani.octopoints.service

import dev.tpavani.octopoints.db.dao.IDao
import dev.tpavani.octopoints.service.impl.DBMatchService
import dev.tpavani.octopoints.service.impl.DBTeamService
import dev.tpavani.octopoints.service.impl.DBUserService
import dev.tpavani.octopoints.service.model.OctopointsModel
import dev.tpavani.octopoints.service.utils.GetListFilter

abstract class DBService<T, E> where T:OctopointsModel{

    protected abstract val dao: IDao<E>

    protected abstract fun entityMapper(model: T): E

    suspend fun create(model: T) {
        val id: Long = dao.create(entityMapper(model))
        model.setId(id.toInt())
    }

    abstract suspend fun getList(filter: GetListFilter): MutableList<T>

    suspend fun update(list: List<T>): Boolean {
        return dao.modify(list.map { entityMapper(it) }) == list.size
    }
    suspend fun delete(item: T): Boolean {
        return dao.remove(entityMapper(item)) == 1
    }

    companion object Factory {
        fun getMatchService(): DBMatchService = DBMatchService()
        fun getUserService(): DBUserService = DBUserService()
        fun getTeamService(): DBTeamService = DBTeamService()
    }
}