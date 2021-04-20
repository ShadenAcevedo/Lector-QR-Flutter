
import 'package:flutter/cupertino.dart';
import 'package:lector_qr/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';



launchURL(BuildContext context, ScanModel scan) async{
  final _url = scan.valor;
  if(scan.tipo == 'http') {
    //Abrir el sitio web por medio de la url
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  } else {
    //navegar al mapa con las cordenadas
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
