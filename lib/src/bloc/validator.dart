import 'dart:async';

import 'package:qr_reader_app/src/models/scan_model.dart';

class Validator{

  final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink){
      final geoScans =  scans.where((s) => s.tipo == 'geo').toList();
      sink.add(geoScans);
    } ,
  );

  final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink){
      final httpScans = scans.where((s) => s.tipo == 'http').toList();
      sink.add(httpScans);
    } ,
  );

  final validarText = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink){
      final textScans = scans.where((s) => s.tipo == 'text').toList();
      sink.add(textScans);
    } ,
  );

}