package dev.tpavani.octopoints.service

import dev.tpavani.octopoints.service.impl.MatchServiceImpl
import dev.tpavani.octopoints.service.impl.RuleServiceImpl
import dev.tpavani.octopoints.service.impl.TeamServiceImpl
import dev.tpavani.octopoints.service.impl.UserServiceImpl

class OctopointsService {
    companion object {
        fun getMatchService(): MatchService{
            return MatchServiceImpl()
        }

        fun getRuleService(): RuleService{
            return RuleServiceImpl()
        }

        fun getUserService(): UserService{
            return UserServiceImpl()
        }

        fun getTeamService(): TeamService{
            return TeamServiceImpl()
        }
    }
}