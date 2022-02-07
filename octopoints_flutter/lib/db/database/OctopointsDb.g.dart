// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OctopointsDb.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorOctopointsDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$OctopointsDbBuilder databaseBuilder(String name) =>
      _$OctopointsDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$OctopointsDbBuilder inMemoryDatabaseBuilder() =>
      _$OctopointsDbBuilder(null);
}

class _$OctopointsDbBuilder {
  _$OctopointsDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$OctopointsDbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$OctopointsDbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<OctopointsDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$OctopointsDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$OctopointsDb extends OctopointsDb {
  _$OctopointsDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MatchDao? _matchDaoInstance;

  UserDao? _userDaoInstance;

  TeamDao? _teamDaoInstance;

  JoinTeamDao? _joinTeamDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `matches` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT NOT NULL, `gameMode` INTEGER NOT NULL, `points` INTEGER NOT NULL, `survivors` INTEGER NOT NULL, `isActive` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT NOT NULL, `win` INTEGER NOT NULL, `lose` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `teams` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `matchId` INTEGER NOT NULL, `name` TEXT NOT NULL, `partial` INTEGER NOT NULL, `total` INTEGER NOT NULL, FOREIGN KEY (`matchId`) REFERENCES `matches` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `jointeam` (`teamId` INTEGER NOT NULL, `userId` INTEGER NOT NULL, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`teamId`, `userId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MatchDao get matchDao {
    return _matchDaoInstance ??= _$MatchDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  TeamDao get teamDao {
    return _teamDaoInstance ??= _$TeamDao(database, changeListener);
  }

  @override
  JoinTeamDao get joinTeamDao {
    return _joinTeamDaoInstance ??= _$JoinTeamDao(database, changeListener);
  }
}

class _$MatchDao extends MatchDao {
  _$MatchDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _matchEntityInsertionAdapter = InsertionAdapter(
            database,
            'matches',
            (MatchEntity item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'gameMode': item.gameMode,
                  'points': item.points,
                  'survivors': item.survivors,
                  'isActive': item.isActive ? 1 : 0
                }),
        _matchEntityUpdateAdapter = UpdateAdapter(
            database,
            'matches',
            ['id'],
            (MatchEntity item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'gameMode': item.gameMode,
                  'points': item.points,
                  'survivors': item.survivors,
                  'isActive': item.isActive ? 1 : 0
                }),
        _matchEntityDeletionAdapter = DeletionAdapter(
            database,
            'matches',
            ['id'],
            (MatchEntity item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'gameMode': item.gameMode,
                  'points': item.points,
                  'survivors': item.survivors,
                  'isActive': item.isActive ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MatchEntity> _matchEntityInsertionAdapter;

  final UpdateAdapter<MatchEntity> _matchEntityUpdateAdapter;

  final DeletionAdapter<MatchEntity> _matchEntityDeletionAdapter;

  @override
  Future<List<MatchEntity>> getMatches(bool active) async {
    return _queryAdapter.queryList(
        'SELECT * FROM matches WHERE isActive=?1 ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => MatchEntity(
            row['id'] as int?,
            row['description'] as String,
            row['gameMode'] as int,
            row['points'] as int,
            row['survivors'] as int,
            (row['isActive'] as int) != 0),
        arguments: [active ? 1 : 0]);
  }

  @override
  Future<int> create(MatchEntity t) {
    return _matchEntityInsertionAdapter.insertAndReturnId(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(List<MatchEntity> t) {
    return _matchEntityUpdateAdapter.updateListAndReturnChangedRows(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(MatchEntity t) {
    return _matchEntityDeletionAdapter.deleteAndReturnChangedRows(t);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'win': item.win,
                  'lose': item.lose
                }),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'win': item.win,
                  'lose': item.lose
                }),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'win': item.win,
                  'lose': item.lose
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<List<UserEntity>> getAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM users ORDER BY username',
        mapper: (Map<String, Object?> row) => UserEntity(row['id'] as int?,
            row['username'] as String, row['win'] as int, row['lose'] as int));
  }

  @override
  Future<UserEntity?> getUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM users WHERE id=?1',
        mapper: (Map<String, Object?> row) => UserEntity(row['id'] as int?,
            row['username'] as String, row['win'] as int, row['lose'] as int),
        arguments: [id]);
  }

  @override
  Future<int> create(UserEntity t) {
    return _userEntityInsertionAdapter.insertAndReturnId(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(List<UserEntity> t) {
    return _userEntityUpdateAdapter.updateListAndReturnChangedRows(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(UserEntity t) {
    return _userEntityDeletionAdapter.deleteAndReturnChangedRows(t);
  }
}

class _$TeamDao extends TeamDao {
  _$TeamDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _teamEntityInsertionAdapter = InsertionAdapter(
            database,
            'teams',
            (TeamEntity item) => <String, Object?>{
                  'id': item.id,
                  'matchId': item.matchId,
                  'name': item.name,
                  'partial': item.partial,
                  'total': item.total
                }),
        _teamEntityUpdateAdapter = UpdateAdapter(
            database,
            'teams',
            ['id'],
            (TeamEntity item) => <String, Object?>{
                  'id': item.id,
                  'matchId': item.matchId,
                  'name': item.name,
                  'partial': item.partial,
                  'total': item.total
                }),
        _teamEntityDeletionAdapter = DeletionAdapter(
            database,
            'teams',
            ['id'],
            (TeamEntity item) => <String, Object?>{
                  'id': item.id,
                  'matchId': item.matchId,
                  'name': item.name,
                  'partial': item.partial,
                  'total': item.total
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TeamEntity> _teamEntityInsertionAdapter;

  final UpdateAdapter<TeamEntity> _teamEntityUpdateAdapter;

  final DeletionAdapter<TeamEntity> _teamEntityDeletionAdapter;

  @override
  Future<List<TeamEntity>> getTeamsByMatchId(int id) async {
    return _queryAdapter.queryList('SELECT * FROM teams WHERE matchId=?1',
        mapper: (Map<String, Object?> row) => TeamEntity(
            row['id'] as int?,
            row['matchId'] as int,
            row['name'] as String,
            row['partial'] as int,
            row['total'] as int),
        arguments: [id]);
  }

  @override
  Future<int> create(TeamEntity t) {
    return _teamEntityInsertionAdapter.insertAndReturnId(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(List<TeamEntity> t) {
    return _teamEntityUpdateAdapter.updateListAndReturnChangedRows(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(TeamEntity t) {
    return _teamEntityDeletionAdapter.deleteAndReturnChangedRows(t);
  }
}

class _$JoinTeamDao extends JoinTeamDao {
  _$JoinTeamDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _joinTeamEntityInsertionAdapter = InsertionAdapter(
            database,
            'jointeam',
            (JoinTeamEntity item) => <String, Object?>{
                  'teamId': item.teamId,
                  'userId': item.userId
                }),
        _joinTeamEntityUpdateAdapter = UpdateAdapter(
            database,
            'jointeam',
            ['teamId', 'userId'],
            (JoinTeamEntity item) => <String, Object?>{
                  'teamId': item.teamId,
                  'userId': item.userId
                }),
        _joinTeamEntityDeletionAdapter = DeletionAdapter(
            database,
            'jointeam',
            ['teamId', 'userId'],
            (JoinTeamEntity item) => <String, Object?>{
                  'teamId': item.teamId,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<JoinTeamEntity> _joinTeamEntityInsertionAdapter;

  final UpdateAdapter<JoinTeamEntity> _joinTeamEntityUpdateAdapter;

  final DeletionAdapter<JoinTeamEntity> _joinTeamEntityDeletionAdapter;

  @override
  Future<List<UserEntity>> getTeammates(int teamId) async {
    return _queryAdapter.queryList(
        'SELECT U.* FROM users U, jointeam J WHERE J.teamId=?1 AND J.userId=U.id',
        mapper: (Map<String, Object?> row) => UserEntity(row['id'] as int?, row['username'] as String, row['win'] as int, row['lose'] as int),
        arguments: [teamId]);
  }

  @override
  Future<int> create(JoinTeamEntity t) {
    return _joinTeamEntityInsertionAdapter.insertAndReturnId(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(List<JoinTeamEntity> t) {
    return _joinTeamEntityUpdateAdapter.updateListAndReturnChangedRows(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(JoinTeamEntity t) {
    return _joinTeamEntityDeletionAdapter.deleteAndReturnChangedRows(t);
  }
}
