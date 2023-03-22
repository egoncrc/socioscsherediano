import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:socioscsherediano/models/models.dart';
import 'package:socioscsherediano/providers/db_provider.dart';


class EntradaService extends ChangeNotifier{

  final String _baseUrl ='http://161.22.47.35:8055/items';
  //final String _baseUrl ='http://161.22.47.35:8055/items';
  final List<Entrada> entradas =[];
  final List<EntradaModel> listaEntradas =[];    
  final List<String> listaZonas =[];
  final List<String> listaPartidos =[];
  EntradaModel? entradaHoy = null;
  
  bool isLoading = true;
  bool isSaving= false;  
  final storage= const FlutterSecureStorage();
  

  EntradaService() {
    //loadEntradas();
  }

//
 Future<List<Entrada>> loadEntradas() async{
    final String _accessToken = await storage.read(key:'token') ?? '';
    final String _socio = await storage.read(key:'socio') ?? '';
    isLoading = true;
    notifyListeners();

    final String mes,dia;
    final DateTime fechaHoy  = DateTime.now();
    fechaHoy.day<10 ? dia ='0${fechaHoy.day}' : dia ='${fechaHoy.day}';
    fechaHoy.month<10 ? mes ='0${fechaHoy.month}' : mes ='${fechaHoy.month}';
    final String fechaHoyStr = '$dia-$mes-${fechaHoy.year}';

    //final int del=await DBProvider.db.deleteAllEntradas();
    listaEntradas.clear();
    listaZonas.clear();
    listaPartidos.clear();
    entradas.clear();
    listaEntradas.addAll(await DBProvider.db.getListaEntradasBySocio(_socio));
    
    if(listaEntradas.isEmpty){      
      final url = Uri.parse('$_baseUrl/entradas?filter={"_and":[{"membresia":{"socio":{"user":{"id":{"_eq":"$_socio"}}}}},{"membresia":{"estadomembresia":{"_eq":1}}}]}&fields[]=juego.jornada,juego.equipo.nombre,juego.fecha,juego.hora,juego.estadio.nombre,membresia.zonasilla.zona.id,membresia.zonasilla.zona.nombre,membresia.zonasilla.silla.numero,entrada,membresia.id,membresia.socio.user' );
      final headers = {"Content-type": "application/json", HttpHeaders.authorizationHeader: 'Bearer $_accessToken'};
      final resp= await http.get(url, headers: headers);
      //print(url);
      final entradasResponse = EntradasResponse.fromJson(resp.body);
      entradas.addAll(entradasResponse.data);    

      entradas.forEach((ent) async {
        final String subFecha = ent.juego.fecha.toString().substring(0,10);
        final arrFecha = subFecha.split('-').reversed;        
        final String fechaJuego = arrFecha.join("-");
        
        final nuevaEntrada = EntradaModel(entrada: ent.entrada,equipo: ent.juego.equipo.nombre,estadio: ent.juego.estadio.nombre,fecha: fechaJuego,hora: ent.juego.hora, jornada: ent.juego.jornada , zona: ent.membresia.zonasilla.zona.nombre,silla: ent.membresia.zonasilla.silla.numero,socio: ent.membresia.socio.user );
        final id= await DBProvider.db.nuevaEntrada(nuevaEntrada);
        //print('Entrada ${id}');
      });
      
      listaEntradas.addAll(await DBProvider.db.getListaEntradasBySocio(_socio));

    }
  
    listaZonas.addAll(await DBProvider.db.getZonasPorSocio(_socio));
    listaPartidos.addAll(await DBProvider.db.getListaPartidosPorSocio(_socio));
    //entradaHoy = await DBProvider.db.getEntradaByFecha(fechaHoyStr); 
    entradaHoy = await DBProvider.db.getEntradaByFecha('28-01-2023');
    final ticketHoy = listaEntradas.where((ticket) => ticket.fecha.contains('28-01-2023')).first;
    await DBProvider.db.deleteEntradaPorJornada(ticketHoy.jornada);
    isLoading = false;
    notifyListeners();
    return entradas; // ESTE RETORNO ESTA DEMÁS YA QUE LA LISTA entradas se accesa desde provider
 }


 

}