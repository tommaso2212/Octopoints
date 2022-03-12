import 'package:floor/floor.dart';

@Entity(tableName: 'matches')
class MatchEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final bool isActive;

  MatchEntity(
    this.id,
    this.name,
    this.isActive,
  );
}
