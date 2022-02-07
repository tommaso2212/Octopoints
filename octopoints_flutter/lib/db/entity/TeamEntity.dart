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
  final String name;
  final int partial;
  final int total;

  TeamEntity(this.id, this.matchId, this.name, this.partial, this.total);
}
