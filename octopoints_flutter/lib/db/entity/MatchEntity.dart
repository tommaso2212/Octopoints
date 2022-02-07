import 'package:floor/floor.dart';

@Entity(tableName: 'matches')
class MatchEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String description;
  final int gameMode;
  final int points;
  final int survivors;
  final bool isActive;

  MatchEntity(this.id, this.description, this.gameMode, this.points, this.survivors, this.isActive);
}
