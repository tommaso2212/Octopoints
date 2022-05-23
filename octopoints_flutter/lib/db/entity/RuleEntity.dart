import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/entity/MatchEntity.dart';

@Entity(tableName: 'rules', foreignKeys: [
  ForeignKey(
    childColumns: ['matchId'],
    parentColumns: ['id'],
    entity: MatchEntity,
    onDelete: ForeignKeyAction.cascade,
  )
])
class RuleEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int matchId;
  final int numVincitori;
  final int total;
  final int totalIncrement;
  final bool partialIncrement;

  RuleEntity(
    this.id,
    this.matchId,
    this.numVincitori,
    this.total,
    this.totalIncrement,
    this.partialIncrement
  );
}
