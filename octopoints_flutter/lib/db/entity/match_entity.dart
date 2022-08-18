import 'package:floor/floor.dart';

@Entity(tableName: 'matches')
class MatchEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;

  MatchEntity(this.id, this.name);
}
