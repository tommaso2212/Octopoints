import 'package:floor/floor.dart';

@Entity(tableName: 'users')
class UserEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  int win;
  int lose;
  int draw;

  UserEntity(this.username,
      {this.id, this.win = 0, this.lose = 0, this.draw = 0});
}
