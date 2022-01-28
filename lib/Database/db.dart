import 'package:app_develop/model/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {

  static final DB instance = DB._init();
  static Database? _database;
  DB._init();


  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('dataQr.db');
    return _database;
  }

  Future<Database?> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute(
        'CREATE TABLE $tableData (${DataFields.id} $idType, ${DataFields.type} $textType , ${DataFields.value} $textType )');
  }

  Future<Data> insertData(Data data) async {
    final db = await database;
    final id = await db?.insert(tableData,data.toJson());
    return data.copy(id: id);
  }

  Future<Data> readData(int id) async {
    final db = await instance.database;
    final maps = await db!.query(tableData,columns: DataFields.values, where: '${DataFields.id} = ?', whereArgs: [id],);

    if (maps.isNotEmpty){
      return Data.fromJson(maps.first);
    }else{
      throw Exception('Data $id not found');
    }
  }

  Future<List<Data>> readAllData() async {
    final db = await instance.database;
    final result = await db?.query(tableData);
    return result!.map((json) => Data.fromJson(json)).toList();
  }

  Future<int> deleteData(int id) async {
    final db = await instance.database;
    
    return await db!.delete(tableData, where: '${DataFields.id} = ?', whereArgs: [id]);
  }


  Future close() async {
    final db = await instance.database;
    db?.close();
  }
}
