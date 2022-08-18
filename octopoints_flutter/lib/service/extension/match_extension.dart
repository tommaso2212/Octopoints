import 'package:octopoints_flutter/db/database.dart';
import 'package:octopoints_flutter/service/service.dart';

extension MatchModelExtension on Match {
  MatchEntity toMatchEntity() {
    return MatchEntity(id != 0 ? id : null, name);
  }

  Match setId(int id) {
    return Match(id: id, name: name);
  }
}

extension MatchEntityExtension on MatchEntity {
  Match toMatchModel() {
    return Match(id: id!, name: name);
  }
}
