package dev.tpavani.octopoints.service.impl

import dev.tpavani.octopoints.db.DbSingleton
import dev.tpavani.octopoints.service.UserService
import dev.tpavani.octopoints.service.model.User
import dev.tpavani.octopoints.service.utils.ModelMapper

class UserServiceImpl: UserService {
    override suspend fun createUser(user: User): User {
        var id: Int = DbSingleton.getDb().userDao().create(ModelMapper.toUserEntity(user))
        return user.setId(id)
    }

    override suspend fun deleteUser(user: User) {
        DbSingleton.getDb().userDao().remove(ModelMapper.toUserEntity(user))
    }

    override suspend fun getUsers(): List<User> {
        return DbSingleton.getDb().userDao().getAllUsers().map { e -> ModelMapper.toUserModel(e)}
    }

    override suspend fun updateUser(users: List<User>) {
        DbSingleton.getDb().userDao().modify(users.map { e-> ModelMapper.toUserEntity(e) })
    }

}