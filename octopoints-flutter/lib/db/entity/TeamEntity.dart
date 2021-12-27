import 'package:floor/floor.dart';
import 'package:octopoints/db/entity/MatchEntity.dart';

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
  @ColumnInfo(name: 'id')
  final int? id;
  @ColumnInfo(name: 'matchId')
  final int matchId;
  int partial;
  int total;

  TeamEntity(this.matchId, {this.id, this.partial = 0, this.total = 0});
}
