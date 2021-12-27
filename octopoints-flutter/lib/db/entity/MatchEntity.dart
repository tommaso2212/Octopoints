import 'package:floor/floor.dart';

@Entity(tableName: 'matches')
class MatchEntity {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;
  @ColumnInfo(name: 'description')
  final String description;

  final int
      gameMode; //vince il primo che arriva a n punti, perde il primo che arriva a n punti, rimangono n giocatori
  final int points;
  final int survivors;

  MatchEntity(this.description,
      {this.id, this.gameMode = 0, this.points = 1, this.survivors = 1});
}
