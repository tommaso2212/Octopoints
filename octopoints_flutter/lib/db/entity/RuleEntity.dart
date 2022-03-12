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
  final int ifArgument;
  final int ifCondition;
  final int ifValue;
  final int thenArgument;
  final int? thenValue;

  RuleEntity(
    this.id,
    this.matchId,
    this.ifArgument,
    this.ifCondition,
    this.ifValue,
    this.thenArgument,
    this.thenValue,
  );
}
