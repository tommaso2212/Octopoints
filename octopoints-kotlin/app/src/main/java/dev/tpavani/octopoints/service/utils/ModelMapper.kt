package dev.tpavani.octopoints.service.utils

import dev.tpavani.octopoints.db.entity.MatchEntity
import dev.tpavani.octopoints.db.entity.RuleEntity
import dev.tpavani.octopoints.db.entity.TeamEntity
import dev.tpavani.octopoints.db.entity.UserEntity
import dev.tpavani.octopoints.service.model.Match
import dev.tpavani.octopoints.service.model.Rule
import dev.tpavani.octopoints.service.model.Team
import dev.tpavani.octopoints.service.model.User

class ModelMapper {
 companion object {
     fun toMatchEntity(model: Match): MatchEntity {
         return MatchEntity(model.getId(), model.getName())
     }

     fun toMatchModel(entity: MatchEntity): Match {
         return Match(entity.id, entity.name)
     }

     fun toUserEntity(model: User): UserEntity{
         return UserEntity(model.getId(), model.getUsername(), model.getWin(), model.getLose())
     }

     fun toUserModel(entity: UserEntity): User{
         return User(entity.id, entity.username, entity.win, entity.lose)
     }

     fun toRuleEntity(model: Rule): RuleEntity{
         return RuleEntity(model.getId(), model.matchId, model.winners, model.total, model.battleRoyale)
     }

     fun toRuleModel(entity: RuleEntity?): Rule?{
         if(entity == null){
             return null
         }
         return Rule(entity.id, entity.matchId, entity.winners, entity.total, entity.battleRoyale)
     }

     fun toTeamEntity(model: Team): TeamEntity{
         return TeamEntity(model.getId(), model.getMatchId(), model.total, model.partial, model.status.ordinal)
     }

     fun toTeamModel(entity: TeamEntity): Team {
         return Team(entity.id, entity.matchId, entity.total, entity.partial, Team.TeamStatusEnum.values()[entity.status])
     }
 }
}