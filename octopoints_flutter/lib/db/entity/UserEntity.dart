import 'package:floor/floor.dart';

@Entity(tableName: 'users')
class UserEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  final int win;
  final int lose;

  UserEntity(this.id, this.username, this.win, this.lose);
}
