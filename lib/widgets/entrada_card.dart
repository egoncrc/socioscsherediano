import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:socioscsherediano/models/models.dart';

class EntradaCard extends StatelessWidget {

  final int jornada;
  final String fecha;
  final String hora;
  final String equipo;
  final String estadio;
  final String zona;
  final String silla;
  final String entrada; 
  const EntradaCard({Key? key,required this.entrada, required this.jornada, required this.fecha, required this.hora, required this.equipo, required this.estadio, required this.zona, required this.silla}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _ticketCardDecoration(),      
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text('Jornada #$jornada',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey[800])),
            Text('Locación: $zona - Asiento: $silla',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 1, 25, 69))),
            Text('Club Sport Herediano VS $equipo',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey[800])),
            Divider(color: Colors.black,),
            SizedBox(height: 10,),
            //Text('Asiento: $silla',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black)),
            //Text('Estadio: $estadio',style: TextStyle(fontSize: 14, color: Colors.black)),
            //Text('Fecha: $fecha Hora: $hora',style: TextStyle(fontSize: 14, color: Colors.black)),
            QrImage(
              data: entrada, 
              size:450,
              version: QrVersions.auto,
            ),
            Divider(color: Colors.black,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,              
                children: const [
                Icon(Icons.share_outlined),
                Text('Compartir Entrada')
              ]),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  BoxDecoration _ticketCardDecoration() => const BoxDecoration(
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