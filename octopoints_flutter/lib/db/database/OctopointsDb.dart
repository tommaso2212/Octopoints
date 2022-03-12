import 'package:floor/floor.dart';
import 'package:octopoints_flutter/db/dao/RuleDao.dart';
import 'package:octopoints_flutter/db/dao/TeamUserRelationDao.dart';
import 'package:octopoints_flutter/db/dao/MatchDao.dart';
import 'package:octopoints_flutter/db/dao/TeamDao.dart';
import 'package:octopoints_flutter/db/dao/UserDao.dart';
import 'package:octopoints_flutter/db/entity/MatchEntity.dart';
import 'package:octopoints_flutter/db/entity/RuleEntity.dart';
import 'package:octopoints_flutter/db/entity/TeamEntity.dart';
import 'package:octopoints_flutter/db/entity/TeamUserRelation.dart';
import 'package:octopoints_flutter/db/entity/UserEntity.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'OctopointsDb.g.dart';

@Database(
  version: 1,
  entities: [MatchEntity, UserEntity, TeamEntity, TeamUserRelation, RuleEntity],
)
abstract class OctopointsDb extends FloorDatabase {
  MatchDao get matchDao;
  UserDao get userDao;
  TeamDao get teamDao;
  TeamUserRelationDao get teamUserRelationDao;
  RuleDao get ruleDao;
}
