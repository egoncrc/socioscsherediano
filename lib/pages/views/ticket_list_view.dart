import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:socioscsherediano/pages/views/ticket_view.dart';
import 'package:socioscsherediano/services/services.dart';

class TicketListView extends StatelessWidget {
  const TicketListView({super.key});

  @override
  Widget build(BuildContext context) {
    final entradaService = context.watch<EntradaService>();
    final entradaActual = entradaService.entradaHoy;

    return Container(
        decoration: _tickedListDecoration(),
        child: entradaActual == null
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                height: 50,
                alignment: Alignment.center,
                //decoration: _tickedListCardDecoration(),
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    const Text('No hay partidos programados para el día de hoy.',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.yellow)),
                    const Text('Revise la opción de Jornadas, para ver el',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.yellow)),
                    const Text('próximo partido en casa de nuestro equipo',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.yellow)),
                    Image(image: AssetImage('assets/escudo.png'),height:200,),
                    
                  ],
                ),
              )
            : ListView.builder(
                itemCount: entradaService.listaZonas.length,
                itemBuilder: (BuildContext context, int index) {
                  final zona = entradaService.listaZonas[index];

                  return GestureDetector(
                    onTap: () {
                      // Navegar a la vista del ticket aquí
                      //Navigator.pushNamed(context, 'ticket');
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: TicketView(zonaNombre: zona));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      height: 200,
                      alignment: Alignment.center,
                      decoration: _tickedListCardDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text('JORNADA #${entradaActual.jornada}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          SizedBox(  height: 5, ),
                          Text('Club Sport Herediano',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                                  Text('VS',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                                  Text('${entradaActual.equipo}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),                          
                          SizedBox(
                            height: 5,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              //child: Icon(Icons.account_circle),
                              backgroundImage: AssetImage('assets/escudo.png'),
                              backgroundColor: Colors.grey.withOpacity(0),
                              radius: 20,
                            ),
                            title: Text(zona,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 1, 84, 151))),
                            subtitle: Text('Ver aquí sus entradas',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 1, 84, 151))),
                            trailing: Icon(Icons.arrow_circle_right_outlined,
                                size: 40,
                                color: Color.fromARGB(255, 1, 84, 151)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}

BoxDecoration _tickedListDecoration() => const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color.fromARGB(255, 116, 16, 3),
          Color.fromRGBO(255, 194, 14, 0.8),
          // Color.fromRGBO(21,176,179, 1),
        ]));

BoxDecoration _tickedListCardDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 236, 237, 238),
            Color.fromRGBO(159, 159, 157, 0.8),
            // Color.fromRGBO(21,176,179, 1),
          ]),
      boxShadow: [
        BoxShadow(
          color: Colors.black54.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 6,
          offset: Offset(0, 7),
        ),
      ],
);
