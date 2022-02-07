package dev.tpavani.octopoints

import dev.tpavani.octopoints.db.DbSingleton
import org.junit.Test
import androidx.test.core.app.ApplicationProvider
import dev.tpavani.octopoints.service.DBService
import dev.tpavani.octopoints.service.impl.DBMatchService
import dev.tpavani.octopoints.service.impl.DBTeamService
import dev.tpavani.octopoints.service.impl.DBUserService
import dev.tpavani.octopoints.service.model.Match
import dev.tpavani.octopoints.service.model.Team
import dev.tpavani.octopoints.service.model.User
import dev.tpavani.octopoints.service.utils.GetListFilter
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
        val userService: DBUserService = DBService.getUserService()
        var user = User("username")

        runBlocking {
            userService.create(user)
            assertNotEquals(0, user.getId())
            user.addWin()
            assertEquals(true, userService.update(listOf(user)))
            assertEquals(1, userService.getList(GetListFilter())[0].getWin())
            assertEquals("username", userService.getList(GetListFilter().setId(user.getId())).first()
                .getUsername())
            assertEquals(true, userService.delete(user))
            assertEquals(0, userService.getList(GetListFilter()).size)
        }
    }

    @Test
    fun matchTest(){
        val matchService: DBMatchService = DBService.getMatchService()
        var match = Match("description", Match.GameMode.FIRST_TO_TOTAL, 3, 1)

        runBlocking {
            matchService.create(match)
            assertNotEquals(0, match.getId())
            teamTest(match)
            assertEquals(1, matchService.getList(GetListFilter().setActive(true)).size)
            assertEquals(true, matchService.update(listOf(match.archiveMatch())))
            assertEquals(true, matchService.delete(match))
        }
    }

    private suspend fun teamTest(match: Match) {
        val teamService: DBTeamService = DBService.getTeamService()
        var team = Team(match.getId(), "team")
        val user = User("username")
        DBService.getUserService().create(user)
        teamService.create(team)
        assertNotEquals(0, team.getId())
        team.total++
        assertEquals(true, teamService.update(listOf(team)))
        teamService.joinTeam(team, user)
        match.teams = teamService.getList(GetListFilter().setId(match.getId()))
        assertEquals(1, match.teams.size)
        assertEquals(1, match.teams[0].users.size)
        teamService.leaveTeam(team, user)
        assertEquals(0, team.users.size)
        assertEquals(true, teamService.delete(team))
    }
}