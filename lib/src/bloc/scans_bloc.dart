import 'dart:async';

import 'package:qr_reader_app/src/providers/db_provider.dart';

class ScansBloc{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //Obtener Scans de la Base de datos
  }

  final _scansStreamController = StreamController<List<ScanModel>>.broadcast();
  
  Stream<List<ScanModel>> get scanStream => _scansStreamController.stream;


  dispose(){
    _scansStreamController?.close();
  }

}