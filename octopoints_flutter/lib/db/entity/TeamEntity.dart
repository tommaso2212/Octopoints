import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/entity/MatchEntity.dart';

@Entity(tableName: 'teams', foreignKeys: [
  ForeignKey(
    childColumns: ['matchId'],
    parentColumns: ['id'],
    entity: MatchEntity,
    onDelete: ForeignKeyAction.cascade,
  )
])
class TeamEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int matchId;
  final int partial;
  final int total;
  final int status;

  TeamEntity(
    this.id,
    this.matchId,
    this.partial,
    this.total,
    this.status
  );
}
