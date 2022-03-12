import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/entity/TeamEntity.dart';
import 'package:octopoints_flutter/db/entity/UserEntity.dart';

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
class TeamUserRelation {
  final int teamId;
  final int userId;

  TeamUserRelation(
    this.teamId,
    this.userId,
  );
}
