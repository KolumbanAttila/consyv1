import 'dart:async';
import 'dart:io';
import 'package:consyv1/PoliceModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Police ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "gender TEXT,"
              "dep TEXT,"
              "image TEXT,"
              "age INTEGER"
              ")");
        });
  }

  newPolice(PoliceModel newPolice) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Police");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Police (id,name,gender,dep,image,age)"
            " VALUES (?,?,?,?,?,?)",
        [id, newPolice.name, newPolice.gender, newPolice.dep,newPolice.image,newPolice.age]);
    return raw;
  }


  updatePolice(PoliceModel newPolice) async {
    final db = await database;
    var res = await db.update("Police", newPolice.toMap(),
        where: "id = ?", whereArgs: [newPolice.id]);
    return res;
  }

  getPolice(int id) async {
    final db = await database;
    var res = await db.query("Police", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? PoliceModel.fromMap(res.first) : null;
  }


  Future<List<PoliceModel>> getAllPolices() async {
    final db = await database;
    var res = await db.query("Police");
    List<PoliceModel> list =
    res.isNotEmpty ? res.map((c) => PoliceModel.fromMap(c)).toList() : [];
    return list;
  }

  deletePolice(int id) async {
    final db = await database;
    return db.delete("Police", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Police");
  }
}