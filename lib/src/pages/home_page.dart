import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/pages/direcciones_page.dart';
import 'package:qr_reader_app/src/pages/mapas_page.dart';
import 'package:qr_reader_app/src/providers/db_provider.dart';

import 'package:qrscan/qrscan.dart' as scanner;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _callPage(_currentIndex),
      bottomNavigationBar: _crearBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _crearBottonNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones'),
        )
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  _scanQR() async {
    String cameraScanResult = 'Ahh perro traes el omnitrix';
    // try {
    //   futureString = await scanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }
    // print('futureString $futureString');
    
    if(cameraScanResult != null){
      final scanModel = ScanModel(valor: cameraScanResult);
      DBProvider.db.nuevoScan(scanModel);
    }
  }
}
