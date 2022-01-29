package dev.tpavani.octopoints.service.impl

import dev.tpavani.octopoints.db.DbSingleton
import dev.tpavani.octopoints.db.dao.UserDao
import dev.tpavani.octopoints.db.entity.UserEntity
import dev.tpavani.octopoints.service.DBService
import dev.tpavani.octopoints.service.model.User

class DBUserService : DBService<User> {

    private val userDao: UserDao = DbSingleton.getDb().userDao()

    private fun entityMapper(user: User): UserEntity {
        return UserEntity(user.getId(), user.getUsername(), user.getWin(), user.getLose())
    }

    override suspend fun create(item: User): User {
        val id: Long = userDao.create(UserEntity(username = item.getUsername()))
        return item.setId(id.toInt())
    }

    override suspend fun getList(id: Int?): List<User> {
        return userDao.getAllUsers().map { User(it.id, it.username, it.win, it.lose) }
    }

    override suspend fun update(list: List<User>): Boolean {
        return userDao.modify(list.map { entityMapper(it) }) == list.size    //La query update ritorna il numero delle righe modificate
    }

    override suspend fun delete(item: User): Boolean {
        return userDao.remove(entityMapper(item)) == 1 //La query delete ritorna il numero delle righe eliminate
    }
}