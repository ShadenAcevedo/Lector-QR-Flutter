import 'package:flutter/material.dart';
import 'package:lector_qr/widgets/list_scans.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListScans(tipo: 'geo');
  }
}
