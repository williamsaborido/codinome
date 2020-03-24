import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // criaremos uma variável static, pois nunca irá mudar
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  // criaremos uma classe factory porque não será recriada sempre que chamarmos a classe BD (POO)
  factory DatabaseHelper() => _instance;

  // internal é um construtor então toda vez que precisamos é só instanciá-lo
  DatabaseHelper.internal();

  //Database é a classe do SQFlite que iremos usar, por isso iremos criá-la
  static Database _db;

  // sempre que formos acessar alguma coisa utilizar o future, pois ele é uma transação alheia
  Future<Database> get db async {
    // se o _db existe na memória
    if(_db != null){
      //caso exista, retorna este _bd existente
      return _db;
    }
    // chamamos agora o initBd que irá iniciar o nosso banco de dados
    _db = await initBd();
    return _db;
  }

  // iniciando nosso banco de dados em async pois ele é uma transição
  Future<Database> initBd() async {
    // Directory faz parte do plugin dart:io e o getApplicationDocumentsDirectory() faz parte do path_provider
    // aqui nós estamos acessando o diretório nativo do android
    Directory documentoDiretorio = await getApplicationDocumentsDirectory();

    // o join() junta duas coisas, no caso iremos juntar o diretorio juntamente com o nosso banco de dados
    String caminho = join(
        documentoDiretorio.path, "codinome.db"
    );

    print("Saving at $caminho");

    // após ter acesso ao local do nosso BD, iremos abri-lo
    return await openDatabase(caminho, version: 1, onCreate: _onCreate);
  }

  //criando o método _onCreate que irá criar o nosso BD
  Future _onCreate(Database db, int version) async {
    // aqui iremos colocar o SQL que é outra linguagem, por isso, colocaremos
    // dentro de aspas, pois é string
    await db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, password TEXT)");
  }

  Future<int> CreateAsync(String table, Map<String, dynamic> data) async{
    try{
      return await _db.insert(table, data);
    }
    catch(ex) {
      throw Exception('Error inserting data in the database with message: $ex');
    }
  }

  Future<int> UpdateAsync(String table, Map<String, dynamic> data) async{
    try{
     return await  _db.update(table, data);
    }
    catch(ex) {
      throw Exception('Error updating data in the database with message: $ex');
    }
  }

  Future<int> DeleteAsync(String table, int id) async{
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

  Future<List<Map<String, dynamic>>> ReadAsync(String table) async{
    try{
      return await _db.query(table);
    }
    catch(ex) {
      throw Exception('Error reading data in the database with message: $ex');
    }
  }

  Future<Map<String, dynamic>> GetAsync(String table, int id) async{
    try{
      return await _db.query(table,
      where: "id = ?",
      whereArgs: [id]).then((data) => data.first);
    }
    catch(ex)
    {
      throw Exception('Error querying data in the database with message: $ex');
    }
  }

  Future<List<Map<String, dynamic>>> QueryAsync(String table, String column, dynamic value) async{
    try{

      return await _db.query(table,
        where: "$column = ?",
        whereArgs: [value],
      );
    }
    catch(ex) {
      throw Exception('Error querying data in the database with message: $ex');
    }
  }
}