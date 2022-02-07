import 'package:floor/floor.dart';
import 'package:octopoints/db/entity/TeamEntity.dart';
import 'package:octopoints/db/entity/UserEntity.dart';

@Entity(tableName: 'jointeam', primaryKeys: [
  'teamId',
  'userId'
], foreignKeys: [
  ForeignKey(
      childColumns: ['teamId'],
      parentColumns: ['id'],
      entity: TeamEntity,
      onDelete: ForeignKeyAction.cascade),
  ForeignKey(
      childColumns: ['userId'],
      parentColumns: ['id'],
      entity: UserEntity,
      onDelete: ForeignKeyAction.cascade)
])
class JoinTeamEntity {
  final int teamId;
  final int userId;

  JoinTeamEntity(this.teamId, this.userId);
}
