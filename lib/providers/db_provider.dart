import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socioscsherediano/models/models.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  static Database? _database;
  static final DBProvider db =DBProvider._();
  DBProvider._();

  get database async {
    if(_database != null) return _database!;

    _database = await initDB();

    return _database;
  }

   Future<Database> initDB() async{
    //Path donde se almacena la BD
    //Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //final path = join(documentsDirectory.path, 'EntradasSociosDB.db');
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, 'EntradasSociosDB.db');
    //print(path);

    //Crear Base de Datos

    return await openDatabase(
      path,
      version:1,
      onOpen: (db){},
      onCreate: (Database db, int version) async{        
        await db.execute('''
          CREATE TABLE Entradas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            socio TEXT,
            jornada INTEGER,
            fecha TEXT,
            hora TEXT,
            equipo TEXT,
            estadio TEXT,
            zona TEXT,
            silla TEXT,
            entrada TEXT
          )
        ''');
      }
    );  
  }

  Future<int> nuevaEntrada(EntradaModel nuevaEntrada) async {
    final db = await database;
    final res = await db.insert('Entradas', nuevaEntrada.toJson());
    //print(res);
    return res;
  }

  Future<List<EntradaModel>>getAllEntradas() async{
    final db = await database;
    final res = await db.query('Entradas');
    return res.map<EntradaModel>((entrada) => EntradaModel.fromJson(entrada)).toList();
  }

  

  Future<EntradaModel?>getEntradaByFecha( String fecha) async{
    final db = await database;
    final res = await db.query('Entradas',where: 'fecha=?',whereArgs:[fecha]);
    return res.isNotEmpty
    ? EntradaModel.fromJson(res.first)
    : null;
  }

  Future<List<EntradaModel>>getListaEntradasBySocio( String socio) async{
    final db = await database;
    final res = await db.query('Entradas',where: 'socio=?',whereArgs:[socio]);
    return res.isNotEmpty
    ? res.map<EntradaModel>((entrada) => EntradaModel.fromJson(entrada)).toList()
    : [];
  }

  Future<int> deleteAllEntradas() async{
    final db = await database;
    final res = await db.delete('Entradas');
    return res;
  }

  Future<int> deleteEntrada(int idEntrada) async{
    final db = await database;
    final res = await db.delete('Entradas',where: 'id<?',whereArgs:[idEntrada]);
    return res;
  }

  Future<int> deleteEntradaPorJornada(int jornada) async{
    final db = await database;
    final res = await db.delete('Entradas',where: 'jornada<?',whereArgs:[jornada]);
    return res;
  }

  Future<List<String>> getZonasPorSocio(String socio) async{
    final db = await database;
    List<String> listaMembresias = [];
    
        final List<Map<String, dynamic>> res = await db.rawQuery('''
        SELECT DISTINCT (zona) FROM Entradas WHERE socio = '$socio'
        ''');
    res.forEach((element) {
      listaMembresias.add(element['zona']);
     });
    return res.isNotEmpty
    ? listaMembresias
    : [];
  } 

  Future<List<String>> getListaPartidosPorSocio(String socio) async{
    final db = await database;
    List<String> listaJuegos = [];
    
        final List<Map<String, dynamic>> res = await db.rawQuery('''
        SELECT DISTINCT jornada,fecha,hora,equipo FROM Entradas WHERE socio = '$socio'
        ''');
    res.forEach((element) {
      listaJuegos.add('${element['jornada']} * ${element['equipo']} * ${element['fecha']} * ${element['hora']}');
     });
    return res.isNotEmpty
    ? listaJuegos
    : [];
  }
   

}