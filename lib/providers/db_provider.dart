
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:lector_qr/models/scan_model.dart';
export 'package:lector_qr/models/scan_model.dart';

class DBProvider{
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async{
    if( _database != null) return _database!;
    

    _database = await initDB();

    return _database!;

  }

  Future<Database> initDB() async{

    // path donde se almacena la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScanDB.db');
    print(path);

    // crear base de datos
    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int i) async {
          await db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
            )
          ''');
        }
    );

  }

  // Una forma de llenar los datos en la tabla
  Future<int> nuevoScanRaw( ScanModel nuevoScan ) async{

    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Se verifica la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor) 
      VALUES ($id, '$tipo', '$valor')
    ''');

    return res;
  }


  Future<int> nuevoScan( ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson());
    // res es el id del último registro insertado
    return res;
  }

  Future<ScanModel?> getScanById(int id) async{
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
        ? ScanModel.fromJson(res.first)
        : null;
  }

  Future<List<ScanModel>?> getAllScans() async{
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<List<ScanModel>?> getScanByTipo(String tipo) async{
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> deteleScan(int id) async{
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deteleAllScans() async{
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }

}