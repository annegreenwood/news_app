import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class HelperBase<T> {
  static final String dataBaseName = "news.db";
  Database _database;

  Future<T> getFirst(String title);
  Future<T> save(T object);
  Future<int> delete(String title);
  Future<List> getAll();

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dataBaseName);

    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future _create(Database db, int version) async {
    await db.execute("CREATE TABLE Articles ("
          "title TEXT PRIMARY KEY,"
          "description TEXT,"
          "urlToImage TEXT,"
          "content TEXT"
          ")");

  }
}