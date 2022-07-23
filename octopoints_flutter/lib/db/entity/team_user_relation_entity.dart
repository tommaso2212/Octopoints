import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/database.dart';

@Entity(tableName: 'teamUserRelation', primaryKeys: [
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
class TeamUserRelationEntity {
  final int teamId;
  final int userId;

  TeamUserRelationEntity(
    this.teamId,
    this.userId,
  );
}
