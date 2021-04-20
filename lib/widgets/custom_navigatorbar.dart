import 'package:flutter/material.dart';
import 'package:lector_qr/providers/ui_provider.dart';
import 'package:provider/provider.dart';


class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
        showUnselectedLabels: false,
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        elevation: 0,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Mapa'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration_rounded),
              label: 'Direcciones'
          )
        ]
    );
  }
}
