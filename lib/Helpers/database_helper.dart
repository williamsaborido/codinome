import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static Database _db;
  static DatabaseHelper _instance;

  static Future<void> connect() async{

    if (_db == null){
      await initBd();
    }
  }

  static Future initBd() async {

    Directory storageDir = await getExternalStorageDirectory();
    String path = join(
        storageDir.path, "codinome.db"
    );

    print(path);

    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static void _onCreate(Database db, int version) async {

    await db.execute("CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, password TEXT)");
  }

  static Future<int> CreateAsync(String table, Map<String, dynamic> data) async{
    try{

      return await _db.insert(table, data);
    }
    catch(ex) {

      throw Exception('Error inserting data in the database with message: $ex');
    }
  }

  static Future UpdateAsync(String table, Map<String, dynamic> data) async{
    try{
      _db.update(table, data);
    }
    catch(ex) {
      throw Exception('Error updating data in the database with message: $ex');
    }
  }

  static Future<int> DeleteAsync(String table, int id) async{
    try{
      return await _db.delete(table,
          where: "id = ?",
          whereArgs: [id]
      );
    }
    catch(ex) {
      throw Exception('Error deleting data in the database with message: $ex');
    }
  }

  static Future<Map<String, dynamic>> ReadAsync(String table) async{
    try{

      _db.query(table);
    }
    catch(ex) {
      throw Exception('Error reading data in the database with message: $ex');
    }
  }

  static Future<Map<String, dynamic>> GetAsync(String table, int id) async{
    try{

      var result = await _db.query(table,
      where: "id = ?",
      whereArgs: [id]);

      return result.first;
    }
    catch(ex)
    {
      throw Exception('Error querying data in the database with message: $ex');
    }
  }

  static Future<List<Map<String, dynamic>>> QueryAsync(String table, String column, dynamic value) async{
    try{
      var result = await _db.query(table,
        where: "$column = ?",
        whereArgs: [value],
      );

      return result;
    }
    catch(ex) {
      throw Exception('Error querying data in the database with message: $ex');
    }
  }

  static Future<bool> ExistsAsync(String table, String column, dynamic value) async{
    var result = await _db.query(table,
      where: "$column = ?",
      whereArgs: [value],
    );

    return result.length > 0;
  }

  static Future DisposeAsync() async{

    await _db.close();

    _db = null;

    print('DisposeAsync called');
  }
}