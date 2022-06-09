import 'package:sqflite/sqflite.dart';
import 'package:uas_mobile/sqlite/dbhelper.dart';

class Repository {
  DatabaseHelper _databaseHelper;

  Repository() {
    //initialize database connection
    _databaseHelper = DatabaseHelper();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseHelper.setDatabase();
    return _database;
  }

  //memasukkan data ke tabel
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  //menampilkan data tabel
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  //menampilkan data tabel dengan Id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //mengupdate data
  updateData(table, data) async {
    var connection = await database;
    return await connection
      .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //hapus data
  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
  } 

  //menampilkan data tabel dengan nama kolom
  readDataByColumn(table, columnName, columnValue) async {
    var connection = await database;
    return await connection.query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }
}