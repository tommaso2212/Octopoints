package dev.tpavani.octopoints.service.impl

import dev.tpavani.octopoints.db.DbSingleton
import dev.tpavani.octopoints.db.dao.UserDao
import dev.tpavani.octopoints.db.entity.UserEntity
import dev.tpavani.octopoints.service.DBService
import dev.tpavani.octopoints.service.model.User
import dev.tpavani.octopoints.service.utils.GetListFilter

class DBUserService : DBService<User, UserEntity>() {

    override val dao: UserDao = DbSingleton.getDb().userDao()

    override fun entityMapper(model: User): UserEntity {
        return UserEntity(model.getId(), model.getUsername(), model.getWin(), model.getLose())
    }

    override suspend fun getList(filter: GetListFilter): MutableList<User> {
        if (filter.id != null) {
            val entity = dao.getUserById(filter.id!!)
            if (entity != null) {
                return listOf(User(entity.id, entity.username, entity.win, entity.lose)).toMutableList()
            }
        } else {
            return dao.getAllUsers().map { User(it.id, it.username, it.win, it.lose) }.toMutableList()
        }
        return mutableListOf()
    }
}