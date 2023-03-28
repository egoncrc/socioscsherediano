import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:socioscsherediano/pages/views/ticket_view.dart';
import 'package:socioscsherediano/services/services.dart';

class CalendarListView extends StatelessWidget {
  const CalendarListView({super.key});

  @override
  Widget build(BuildContext context) {
    final entradaService = context.watch<EntradaService>();
    return Container(
        decoration: _calendarListDecoration(),
            child: ListView.builder(
                itemCount: entradaService.listaPartidos.length,                
                itemBuilder: (BuildContext context, int index) {
                  final entrada = entradaService.listaPartidos[index];
                  final juego = entrada.split('*');
                  final jornada = juego[0];
                  final visitante = juego[1];                  
                  final fecha = juego[2];
                  final hora = juego[3];
                  return GestureDetector(
                    onTap: () {
                      // Navegar a la vista del ticket aquí
                      //Navigator.pushNamed(context, 'ticket');
                      
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 159, 112, 4),                            
                            Color.fromARGB(255, 249, 249, 248),
                          ]
                          ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 6,
                            offset: Offset(0, 7),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 5,),
                          Text('Jornada #$jornada',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(248, 176, 31, 2))),
                          ListTile(
                            leading: CircleAvatar(
                              //child: Icon(Icons.account_circle),
                              backgroundImage: AssetImage('assets/escudo.png'),
                              backgroundColor: Colors.grey.withOpacity(0),
                              radius: 20,
                              
                            ),
                            title: Text(' VS $visitante',style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black)),
                            subtitle: Text('Fecha: $fecha  Hora: $hora',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 1, 84, 151))),
                            
                          ),
                          
                        ],
                      ),
                    ),
                  );
                },
            )
          );
  }
}

BoxDecoration _calendarListDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(120, 120, 120, 1),
        Color.fromRGBO(218, 223, 223, 1),
      ]
      )
);