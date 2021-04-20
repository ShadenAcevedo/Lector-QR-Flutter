import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lector_qr/providers/scan_list_provider.dart';
import 'package:lector_qr/utils/utils.dart';
import 'package:provider/provider.dart';


class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async{
        String respScan = await FlutterBarcodeScanner.scanBarcode('#3D8BEF','Cancelar',true,ScanMode.QR);

        //final respScan = 'https://fernando-herrera.com';
        //final respScan = 'geo:4.798171,-75.749366';

        if(respScan == '-1'){ return; }
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(respScan);
        launchURL(context, nuevoScan);
      },
      child: Icon(
        Icons.filter_center_focus
      ),
    );
  }
}
