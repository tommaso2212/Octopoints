package dev.tpavani.octopoints

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import dev.tpavani.octopoints.db.DbSingleton
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
}