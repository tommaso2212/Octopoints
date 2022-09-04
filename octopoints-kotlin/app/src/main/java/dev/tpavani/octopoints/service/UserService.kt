package dev.tpavani.octopoints.service

import dev.tpavani.octopoints.service.model.User

interface UserService {
    suspend fun createUser(user:User): User
    suspend fun deleteUser(user: User)
    suspend fun getUsers(): List<User>
    suspend fun updateUser(users: List<User>)
}