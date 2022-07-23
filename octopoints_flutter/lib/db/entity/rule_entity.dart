import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/database.dart';

@Entity(tableName: 'rules', foreignKeys: [
  ForeignKey(
    childColumns: ['matchId'],
    parentColumns: ['id'],
    entity: MatchEntity,
    onDelete: ForeignKeyAction.cascade,
  )
], indices: [Index(value: ["matchId"], unique: true)])
class RuleEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int matchId;
  final int winners;
  final int total;

  RuleEntity(
    this.id,
    this.matchId,
    this.winners,
    this.total,
  );
}
