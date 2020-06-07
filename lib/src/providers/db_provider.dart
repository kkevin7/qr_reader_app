import 'dart:io';

import 'package:path/path.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
//Model
export 'package:qr_reader_app/src/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')');
    });
  }

  //CREAR Registros
  Future<int> nuevoScanRow(ScanModel scanModel) async {
    final db = await database;
    final res = await db.rawInsert("INSERT INTO Scans(id, tipo, valor) "
        "VALUES (${scanModel.id}, ${scanModel.tipo}, ${scanModel.valor})");
    return res;
  }

  Future<int> nuevoScan(ScanModel scanModel) async {
    final db = await database;
    return await db.insert('Scans', scanModel.toJson());
  }

  //SELECT - Obtener información
  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo' ");
    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
    return list;
  }

  //Actualizar Registros
  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;
    return await db.update('Scans', scanModel.toJson(),
        where: 'id= ?', whereArgs: [scanModel.id]);
  }

  //Eliminar Registros
  Future<int> deleteScan(int id) async {
    final db = await database;
    return await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM Scans');
  }
}
