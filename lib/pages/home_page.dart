import 'package:flutter/material.dart';
import 'package:lector_qr/providers/db_provider.dart';
import 'package:lector_qr/providers/scan_list_provider.dart';
import 'package:lector_qr/providers/ui_provider.dart';
import 'package:provider/provider.dart';

import 'package:lector_qr/pages/adresses_page.dart';
import 'package:lector_qr/pages/history_page.dart';
import 'package:lector_qr/widgets/custom_navigatorbar.dart';
import 'package:lector_qr/widgets/scan_button.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
              onPressed: (){
                Provider.of<ScanListProvider>(context, listen: false).borrarTodos();
              },
              icon: Icon(Icons.delete)
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // leer la base de datos
    //final tempScan = ScanModel(valor: 'http://google.com');
    //DBProvider.db.deteleAllScans().then(print);

    // obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // cambiar el index para ver la pagina respectiva
    final index = uiProvider.selectedMenuOpt;

    // Usar el ScanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false );

    switch(index){
      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return HistoryPage();
      case 1:
        scanListProvider.cargarScanPorTipo('http');
        return AdressesPage();

      default:
        return HistoryPage();
    }

  }
}

