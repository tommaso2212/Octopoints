import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/service.dart';

extension UserModelExtension on User {
  UserEntity toUserEntity() {
    return UserEntity(
      id != 0 ? id : null,
      username,
      win,
      lose,
    );
  }

  User setId(int id) {
    return User(
      id: id,
      username: username,
      win: win,
      lose: lose,
    );
  }
}

extension UserEntityExtension on UserEntity {
  User toUserModel() {
    return User(
      id: id!,
      username: username,
      win: win,
      lose: lose,
    );
  }
}
