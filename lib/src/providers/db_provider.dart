import 'dart:io';

import 'package:path/path.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

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
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')'
        );
      }
    );
  }

  //CREAR Registros
  nuevoScanRow(ScanModel scanModel) async{
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO Scans(id, tipo, valor) "
      "VALUES (${scanModel.id}, ${scanModel.tipo}, ${scanModel.valor})"
    );
    return res;
  }

  nuevoScan(ScanModel scanModel) async{
    final db = await database;
    final res = db.insert('Scans', scanModel.toJson());
    return res;
  }


}
