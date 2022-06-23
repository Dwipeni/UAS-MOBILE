import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_queue_app');
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    //membuat tabel category
    await database.execute(
      "CREATE TABLE category(id INTEGER PRIMARY KEY, name TEXT, description TEXT)"
    );

    //membuat tabel flower
    await database.execute(
      "CREATE TABLE antrean(id INTEGER PRIMARY KEY, name TEXT, nik TEXT, noHp TEXT, tanggal TEXT, alamat TEXT, category TEXT, konfirmasi INT DEFAULT 0)"
    );
  }
}