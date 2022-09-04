package dev.tpavani.octopoints.db

import android.content.Context
import androidx.room.Room
import dev.tpavani.octopoints.db.database.OctopointsDb

class DbSingleton {

    companion object {
        private var db: OctopointsDb? = null

        fun getDb(): OctopointsDb{
            return db!!
        }

        fun initDb(context: Context) {
            db = Room.databaseBuilder(context, OctopointsDb::class.java, "octopoints.db").build()
        }
    }
}