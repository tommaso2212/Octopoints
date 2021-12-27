import 'package:octopoints/db/database/OctopointsDb.dart';

class DbSingleton {
  DbSingleton._();
  static final DbSingleton _instance = DbSingleton._();

  factory DbSingleton() => _instance;

  late OctopointsDb _db;

  OctopointsDb get db => _db;

  Future initDb() =>
      $FloorOctopointsDb.databaseBuilder('octopoints-db').build().then(
            (db) => _db = db,
          );
}
