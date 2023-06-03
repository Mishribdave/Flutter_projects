import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databaseconnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "mydb");
    var database = openDatabase(path, version: 1, onCreate: createtable);
    return database;
  }

  Future<void> createtable(Database database, int version) async {
    String sql =
        "CREATE TABLE USER (id integer primary key autoincrement,name text,contact text)";
    await database.execute(sql);
  }
}
