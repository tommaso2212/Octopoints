import 'package:floor/floor.dart';
import 'package:octopoints/db/dao/JoinTeamDao.dart';
import 'package:octopoints/db/dao/MatchDao.dart';
import 'package:octopoints/db/dao/TeamDao.dart';
import 'package:octopoints/db/dao/UserDao.dart';
import 'package:octopoints/db/entity/JoinTeamEntity.dart';
import 'package:octopoints/db/entity/MatchEntity.dart';
import 'package:octopoints/db/entity/TeamEntity.dart';
import 'package:octopoints/db/entity/UserEntity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'OctopointsDb.g.dart';

@Database(
    version: 1, entities: [MatchEntity, UserEntity, TeamEntity, JoinTeamEntity])
abstract class OctopointsDb extends FloorDatabase {
  MatchDao get matchDao;
  UserDao get userDao;
  TeamDao get teamDao;
  JoinTeamDao get joinTeamDao;
}
