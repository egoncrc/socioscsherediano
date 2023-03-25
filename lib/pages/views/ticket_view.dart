import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socioscsherediano/services/services.dart';
import 'package:socioscsherediano/widgets/widgets.dart';

class TicketView extends StatelessWidget {
  final String zonaNombre;
  const TicketView({Key? key, required this.zonaNombre}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final entradaService = context.watch<EntradaService>();
    final String mes,dia;
    final DateTime fechaHoy  = DateTime.now();
    fechaHoy.day<10 ? dia ='0${fechaHoy.day}' : dia ='${fechaHoy.day}';
    fechaHoy.month<10 ? mes ='0${fechaHoy.month}' : mes ='${fechaHoy.month}';
    //final String fechaHoyStr = '$dia-$mes-${fechaHoy.year}';
    final String fechaHoyStr = '28-01-2023';
    return Container(
      decoration: _tickedViewDecoration(),
      child: ListView.builder(
        
        itemCount: entradaService.listaEntradas.length,
        itemBuilder: (BuildContext context, int index) {
          final entrada = entradaService.listaEntradas[index];
          return Visibility(
            visible: (entrada.zona == zonaNombre && entrada.fecha==fechaHoyStr),
            child: Container(
              
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: EntradaCard(jornada: entrada.jornada, fecha: entrada.fecha,hora:entrada.hora,equipo:entrada.equipo,estadio:entrada.estadio,zona:entrada.zona,silla:entrada.silla, entrada: entrada.entrada),
              )
              ),
          );
        },
      ),
    );
  }
}

BoxDecoration _tickedViewDecoration()=> const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(120, 120, 120, 1),
        Color.fromRGBO(218, 223, 223, 1),
        // Color.fromRGBO(21,176,179, 1),
      ]
      )
  );