import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  Database _db;

  DatabaseHelper();

  Future<DatabaseHelper> instance() async{
    bool exists = await File('/data/user/0/com.ecorp.codinome/app_flutter/codinome.db').exists();
    print('db exists: $exists');
    await initBd();
    print('db set');
    return this;
  }

  Future<Database> initBd() async {
    //Directory documentoDiretorio = await getApplicationDocumentsDirectory();
    Directory documentoDiretorio = await getExternalStorageDirectory();
    String caminho = join(
        documentoDiretorio.path, "codinome.db"
    );
      print('trying create ' + caminho);
    _db = await openDatabase(caminho, version: 1, onCreate: _onCreate);
  }

  static void _onCreate(Database db, int version) async {
    print('calling create');
    await db.execute("CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, password TEXT)");
  }

  Future CreateAsync(String table, Map<String, dynamic> data) async{
    try{
      print('return: ${await _db.insert(table, data)}');
    }
    catch(ex) {
      throw Exception('Error inserting data in the database with message: $ex');
    }
  }

  Future UpdateAsync(String table, Map<String, dynamic> data) async{
    try{
      _db.update(table, data);
    }
    catch(ex) {
      throw Exception('Error updating data in the database with message: $ex');
    }
  }

  Future DeleteAsync(String table, int id) async{
    try{
      _db.delete(table,
          where: "id = ?",
          whereArgs: [id]
      );
    }
    catch(ex) {
      throw Exception('Error deleting data in the database with message: $ex');
    }
  }

  Future<Map<String, dynamic>> ReadAsync(String table) async{
    try{
      _db.query(table);
    }
    catch(ex) {
      throw Exception('Error reading data in the database with message: $ex');
    }
  }

  Future GetAsync(String table, int id) async{
    try{
      _db.query(table,
      where: "id = ?",
      whereArgs: [id]);
    }
    catch(ex)
    {
      throw Exception('Error querying data in the database with message: $ex');
    }
  }

  Future QueryAsync(String table, String column, dynamic value){
    try{
      _db.query(table,
        where: "$column = ?",
        whereArgs: [value],
      );
    }
    catch(ex) {
      throw Exception('Error querying data in the database with message: $ex');
    }
  }

  Future Dispose() async{

    await _db.close();
  }
}