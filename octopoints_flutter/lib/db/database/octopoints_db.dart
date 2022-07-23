import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/database.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'octopoints_db.g.dart';

@Database(
  version: 1,
  entities: [MatchEntity, UserEntity, TeamEntity, TeamUserRelationEntity, RuleEntity],
)
abstract class OctopointsDb extends FloorDatabase {
  MatchDao get matchDao;
  UserDao get userDao;
  TeamDao get teamDao;
  TeamUserRelationDao get teamUserRelationDao;
  RuleDao get ruleDao;
}
