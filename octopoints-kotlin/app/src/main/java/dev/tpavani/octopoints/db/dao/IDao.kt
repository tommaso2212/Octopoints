package dev.tpavani.octopoints.db.dao

import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Update

interface IDao<T> {
    @Insert
    suspend fun create(t: T) : Long

    @Update
    suspend fun modify(list: List<T>) : Int

    @Delete
    suspend fun remove(t: T) : Int
}