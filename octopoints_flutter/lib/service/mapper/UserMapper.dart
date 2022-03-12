import 'package:octopoints_flutter/db/entity/UserEntity.dart';
import 'package:octopoints_flutter/service/model/User.dart';

extension UserModelMapper on User {
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

extension UserEntityMapper on UserEntity {
  User toUserModel() {
    return User(
      id: id!,
      username: username,
      win: win,
      lose: lose,
    );
  }
}
