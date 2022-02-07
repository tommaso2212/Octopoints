import 'package:octopoints/db/database/OctopointsDb.dart';

class DbSingleton {
  DbSingleton._();
  static final DbSingleton _instance = DbSingleton._();

  factory DbSingleton() => _instance;

  static OctopointsDb? _db;

  OctopointsDb get db => _db!;

  Future<void> initDb() async {
    _db = await $FloorOctopointsDb.databaseBuilder('octopoints.db').build();
  }
}
