
import 'package:flutter/material.dart';
import 'package:lector_qr/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async{

    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    // Asignar el Id de la base de datos al modelo
    nuevoScan.id = id;

    if(this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async{
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...?scans];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async{
    final scans = await DBProvider.db.getScanByTipo(tipo);
    this.scans = [...?scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async{
    await DBProvider.db.deteleAllScans();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async{
    await DBProvider.db.deteleScan(id);
  }
}