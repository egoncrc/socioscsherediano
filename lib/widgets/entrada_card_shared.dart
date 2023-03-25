import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:socioscsherediano/models/models.dart';
import 'package:socioscsherediano/pages/views/views.dart';

class EntradaCardShared extends StatelessWidget {

  final int jornada;
  final String fecha;  
  final String equipo;
  
  final String zona;
  final String silla;
  final String entrada; 
  final String nombreInvitado; 
  const EntradaCardShared({Key? key,required this.entrada, required this.jornada, required this.fecha, required this.equipo, required this.zona, required this.silla, required this.nombreInvitado}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TicketCompartido( jornada, zona,  silla,  equipo, entrada,  nombreInvitado),
      ],
    );
  }


Widget _TicketCompartido(int jornada,String zona, String silla, String equipo,String entrada, String nombreInvitado){
 return Container(
          decoration: _ticketCardSharedDecoration(),                
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text('Jornada #$jornada',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey[800])),
                Text('Locación: $zona - Asiento: $silla',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 1, 25, 69))),
                Text('C.S.Herediano VS $equipo',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey[800])),
                SizedBox(height: 5,),
                Divider(color: Colors.black,),
               QrImage(
                  data: entrada, 
                  size:350,
                  version: QrVersions.auto,
                ),
                Divider(color: Colors.black,),            
                SizedBox(height: 5,),
                Text('Compartido por socio(a): $nombreInvitado',style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.grey[800])),
                SizedBox(height: 5,),
              ],
            ),
          ),
        );
}

BoxDecoration _ticketCardSharedDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(189, 188, 188, 0.969),
        // Color.fromRGBO(21,176,179, 1),
        Color.fromRGBO(239, 238, 237, 0.949)
      ]
      ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}


