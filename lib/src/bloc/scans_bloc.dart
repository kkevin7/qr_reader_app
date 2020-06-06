import 'dart:async';

import 'package:qr_reader_app/src/providers/db_provider.dart';

class ScansBloc{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //Obtener Scans de la Base de datos
    obtenerScans();
  }

  final _scansStreamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStream => _scansStreamController.stream;

  dispose(){
    _scansStreamController?.close();
  }

  obtenerScans() async{
    _scansStreamController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async{
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}