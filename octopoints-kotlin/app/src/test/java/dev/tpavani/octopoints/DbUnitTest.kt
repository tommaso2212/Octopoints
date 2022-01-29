package dev.tpavani.octopoints

import dev.tpavani.octopoints.db.DbSingleton
import org.junit.Test
import androidx.test.core.app.ApplicationProvider
import dev.tpavani.octopoints.service.DBService
import dev.tpavani.octopoints.service.impl.DBUserService
import dev.tpavani.octopoints.service.model.User
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotEquals
import org.junit.Before
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner

@RunWith(RobolectricTestRunner::class)
class DbUnitTest {

    @Before
    fun initDb(){
        DbSingleton.initDb(ApplicationProvider.getApplicationContext())
    }

    @Test
    fun userDbTests(){
        val userService: DBService<User> = DBUserService()
        var user = User("username")

        runBlocking {
            user = userService.create(user)
            assertNotEquals(0, user.getId())
            user.addWin()
            assertEquals(true, userService.update(listOf(user)))
            assertEquals(1, userService.getList()[0].getWin())
            assertEquals(true, userService.delete(user))
            assertEquals(0, userService.getList().size)
        }
    }
}