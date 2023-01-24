import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './sqflite_migration/sqflite_migration.dart';

class DatabaseHelper {
  String dbName = "Maintenance8.db";
  // static final MaintainanceDatabase instance = MaintainanceDatabase._init();
  // MaintainanceDatabase._init();
  static Database? _database;

  static List<String> initialScript = [];

  static List<String> migrations = [
    // UserDataHandler.MigrationScript1,
    // UserDataHandler.MigrationScript2,
    // UserDataHandler.MigrationScript3,
  ];
  //

  final config = MigrationConfig(
      initializationScript: initialScript, migrationScripts: migrations);

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    return await openDatabaseWithMigration(path, config);
  }
}
