// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'octopoints_db.dart';

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

  TeamUserRelationDao? _teamUserRelationDaoInstance;

  RuleDao? _ruleDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `matches` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT NOT NULL, `win` INTEGER NOT NULL, `lose` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `teams` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `matchId` INTEGER NOT NULL, `partial` INTEGER NOT NULL, `total` INTEGER NOT NULL, `status` INTEGER NOT NULL, FOREIGN KEY (`matchId`) REFERENCES `matches` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `teamUserRelation` (`teamId` INTEGER NOT NULL, `userId` INTEGER NOT NULL, FOREIGN KEY (`teamId`) REFERENCES `teams` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`teamId`, `userId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `rules` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `matchId` INTEGER NOT NULL, `winners` INTEGER NOT NULL, `total` INTEGER NOT NULL, FOREIGN KEY (`matchId`) REFERENCES `matches` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_rules_matchId` ON `rules` (`matchId`)');

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
  TeamUserRelationDao get teamUserRelationDao {
    return _teamUserRelationDaoInstance ??=
        _$TeamUserRelationDao(database, changeListener);
  }

  @override
  RuleDao get ruleDao {
    return _ruleDaoInstance ??= _$RuleDao(database, changeListener);
  }
}

class _$MatchDao extends MatchDao {
  _$MatchDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _matchEntityInsertionAdapter = InsertionAdapter(
            database,
            'matches',
            (MatchEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _matchEntityUpdateAdapter = UpdateAdapter(
            database,
            'matches',
            ['id'],
            (MatchEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _matchEntityDeletionAdapter = DeletionAdapter(
            database,
            'matches',
            ['id'],
            (MatchEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MatchEntity> _matchEntityInsertionAdapter;

  final UpdateAdapter<MatchEntity> _matchEntityUpdateAdapter;

  final DeletionAdapter<MatchEntity> _matchEntityDeletionAdapter;

  @override
  Future<List<MatchEntity>> getMatches() async {
    return _queryAdapter.queryList('SELECT * FROM matches ORDER BY name',
        mapper: (Map<String, Object?> row) =>
            MatchEntity(row['id'] as int?, row['name'] as String));
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
                  'partial': item.partial,
                  'total': item.total,
                  'status': item.status
                }),
        _teamEntityUpdateAdapter = UpdateAdapter(
            database,
            'teams',
            ['id'],
            (TeamEntity item) => <String, Object?>{
                  'id': item.id,
                  'matchId': item.matchId,
                  'partial': item.partial,
                  'total': item.total,
                  'status': item.status
                }),
        _teamEntityDeletionAdapter = DeletionAdapter(
            database,
            'teams',
            ['id'],
            (TeamEntity item) => <String, Object?>{
                  'id': item.id,
                  'matchId': item.matchId,
                  'partial': item.partial,
                  'total': item.total,
                  'status': item.status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TeamEntity> _teamEntityInsertionAdapter;

  final UpdateAdapter<TeamEntity> _teamEntityUpdateAdapter;

  final DeletionAdapter<TeamEntity> _teamEntityDeletionAdapter;

  @override
  Future<List<TeamEntity>> getTeamsByMatchId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM teams WHERE matchId=?1 ORDER By total DESC',
        mapper: (Map<String, Object?> row) => TeamEntity(
            row['id'] as int?,
            row['matchId'] as int,
            row['partial'] as int,
            row['total'] as int,
            row['status'] as int),
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

class _$TeamUserRelationDao extends TeamUserRelationDao {
  _$TeamUserRelationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _teamUserRelationEntityInsertionAdapter = InsertionAdapter(
            database,
            'teamUserRelation',
            (TeamUserRelationEntity item) => <String, Object?>{
                  'teamId': item.teamId,
                  'userId': item.userId
                }),
        _teamUserRelationEntityUpdateAdapter = UpdateAdapter(
            database,
            'teamUserRelation',
            ['teamId', 'userId'],
            (TeamUserRelationEntity item) => <String, Object?>{
                  'teamId': item.teamId,
                  'userId': item.userId
                }),
        _teamUserRelationEntityDeletionAdapter = DeletionAdapter(
            database,
            'teamUserRelation',
            ['teamId', 'userId'],
            (TeamUserRelationEntity item) => <String, Object?>{
                  'teamId': item.teamId,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TeamUserRelationEntity>
      _teamUserRelationEntityInsertionAdapter;

  final UpdateAdapter<TeamUserRelationEntity>
      _teamUserRelationEntityUpdateAdapter;

  final DeletionAdapter<TeamUserRelationEntity>
      _teamUserRelationEntityDeletionAdapter;

  @override
  Future<List<UserEntity>> getTeammates(int teamId) async {
    return _queryAdapter.queryList(
        'SELECT U.* FROM users U, teamUserRelation J WHERE J.teamId=?1 AND J.userId=U.id',
        mapper: (Map<String, Object?> row) => UserEntity(row['id'] as int?, row['username'] as String, row['win'] as int, row['lose'] as int),
        arguments: [teamId]);
  }

  @override
  Future<void> deleteTeammates(int teamId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM teamUserRelation WHERE teamId=?1',
        arguments: [teamId]);
  }

  @override
  Future<List<int>> addTeammates(List<TeamUserRelationEntity> list) {
    return _teamUserRelationEntityInsertionAdapter.insertListAndReturnIds(
        list, OnConflictStrategy.abort);
  }

  @override
  Future<int> create(TeamUserRelationEntity t) {
    return _teamUserRelationEntityInsertionAdapter.insertAndReturnId(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(List<TeamUserRelationEntity> t) {
    return _teamUserRelationEntityUpdateAdapter.updateListAndReturnChangedRows(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(TeamUserRelationEntity t) {
    return _teamUserRelationEntityDeletionAdapter.deleteAndReturnChangedRows(t);
  }
}

class _$RuleDao extends RuleDao {
  _$RuleDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _ruleEntityInsertionAdapter = InsertionAdapter(
            database,
            'rules',
            (RuleEntity item) => <String, Object?>{
                  'id': item.id,
                  'matchId': item.matchId,
                  'winners': item.winners,
                  'total': item.total
                }),
        _ruleEntityUpdateAdapter = UpdateAdapter(
            database,
            'rules',
            ['id'],
            (RuleEntity item) => <String, Object?>{
                  'id': item.id,
                  'matchId': item.matchId,
                  'winners': item.winners,
                  'total': item.total
                }),
        _ruleEntityDeletionAdapter = DeletionAdapter(
            database,
            'rules',
            ['id'],
            (RuleEntity item) => <String, Object?>{
                  'id': item.id,
                  'matchId': item.matchId,
                  'winners': item.winners,
                  'total': item.total
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RuleEntity> _ruleEntityInsertionAdapter;

  final UpdateAdapter<RuleEntity> _ruleEntityUpdateAdapter;

  final DeletionAdapter<RuleEntity> _ruleEntityDeletionAdapter;

  @override
  Future<RuleEntity?> getRule(int id) async {
    return _queryAdapter.query('SELECT * FROM rules WHERE matchId=?1',
        mapper: (Map<String, Object?> row) => RuleEntity(row['id'] as int?,
            row['matchId'] as int, row['winners'] as int, row['total'] as int),
        arguments: [id]);
  }

  @override
  Future<int> create(RuleEntity t) {
    return _ruleEntityInsertionAdapter.insertAndReturnId(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(List<RuleEntity> t) {
    return _ruleEntityUpdateAdapter.updateListAndReturnChangedRows(
        t, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(RuleEntity t) {
    return _ruleEntityDeletionAdapter.deleteAndReturnChangedRows(t);
  }
}
