
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lector_qr/providers/scan_list_provider.dart';
import 'package:lector_qr/providers/ui_provider.dart';

import 'package:lector_qr/pages/home_page.dart';
import 'package:lector_qr/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UiProvider()
        ),
        ChangeNotifierProvider(
            create: (context) => ScanListProvider()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR reader',
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'map': (context) => MapPage()
        },
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepOrange
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Color(0xffE63707),
          )
        ),
      ),
    );
  }
}
