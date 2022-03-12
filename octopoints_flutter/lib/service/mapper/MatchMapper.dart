import 'package:octopoints_flutter/db/entity/MatchEntity.dart';
import 'package:octopoints_flutter/service/model/Match.dart';

extension MatchModelMapper on Match {
  MatchEntity toMatchEntity() {
    return MatchEntity(
      id != 0 ? id : null,
      name,
      isActive,
    );
  }

  Match setId(int id) {
    return Match(
      id: id,
      name: name,
      isActive: isActive,
    );
  }
}

extension MatchEntityMapper on MatchEntity {
  Match toMatchModel() {
    return Match(
      id: id!,
      name: name,
      isActive: isActive,
    );
  }
}
