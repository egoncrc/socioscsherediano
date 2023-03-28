import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:socioscsherediano/models/models.dart';
import 'package:socioscsherediano/pages/views/views.dart';
import 'package:socioscsherediano/services/services.dart';

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
    final userService = context.read<UserService>();
    return Container(
      decoration: _ticketCardDecoration(),      
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, left:18),
            child: Image(image: AssetImage('assets/escudo.png'),height:40),
          ),
          Center(
          child: Column(
            children: [
              SizedBox(height: 25,),
              Text('Jornada #$jornada',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey[800])),
              Text('$zona - Asiento: $silla',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(248, 176, 31, 2))),
              Text('C.S. Herediano VS $equipo',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 159, 112, 4))),
              SizedBox(height: 10,),
              Divider(color: Colors.black,),
              
              QrImage(
                data: entrada, 
                size:350,
                version: QrVersions.auto,
              ),
              Divider(color: Colors.black,),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,              
                  children: [
                  Icon(Icons.share_outlined),
                  TextButton(
                        onPressed: (){
      
                        //  Navigator.pushReplacementNamed(context, 'register'),
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: TicketSharedView(jornada:jornada,fecha:fecha,equipo:equipo,nombreInvitado: userService.nombreSocio,zona: zona,silla: silla,entrada: entrada,));
      
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                          shape: MaterialStateProperty.all(StadiumBorder())
                        ),
                        child: Text('Compartir Entrada',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blueAccent.shade200),),
                        
                        ),
                ]),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
        ],
      ),
    );
  }

  BoxDecoration _ticketCardDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(252, 251, 251, 0.969),
        Color.fromRGBO(243, 240, 240, 0.969),
        Color.fromRGBO(228, 230, 230, 1),
        Color.fromRGBO(216, 193, 151, 0.91)
      ]
      ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}