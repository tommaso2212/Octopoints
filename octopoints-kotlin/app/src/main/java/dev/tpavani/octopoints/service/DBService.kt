package dev.tpavani.octopoints.service

interface DBService<T> {
    suspend fun create(item: T): T
    suspend fun getList(id: Int? = null): List<T>
    suspend fun update(list: List<T>): Boolean
    suspend fun delete(item: T): Boolean
}