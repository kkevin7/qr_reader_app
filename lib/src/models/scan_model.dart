import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (this.valor.contains('geo')) {
      this.tipo = 'geo';
    }else if(this.valor.substring(0, 4).contains('http') || (this.valor.substring(0, 5).contains('https')) ){
      this.tipo = 'http';
    }else{
      this.tipo = 'text';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };

  LatLng getLatLng(){
    final latlng = valor.substring(4).split(',');
    final lat = double.parse(latlng[0]);
    final lng = double.parse(latlng[1]);
    return LatLng(lat, lng);
  }

}
