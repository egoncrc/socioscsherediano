
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socioscsherediano/widgets/widgets.dart';

class TicketSharedView extends StatelessWidget {
  final int jornada;
  final String fecha;  
  final String equipo;
  final String nombreInvitado;
  final String zona;
  final String silla;
  final String entrada;
  final screenShotController= ScreenshotController();
  TicketSharedView({Key? key, required this.jornada, required this.fecha, required this.equipo, required this.nombreInvitado, required this.zona, required this.silla, required this.entrada}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _tickedViewDecoration(),
      child:  SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Screenshot(
                controller: screenShotController,
                child: EntradaCardShared(jornada: jornada, fecha: fecha,equipo:equipo,nombreInvitado: nombreInvitado,zona:zona,silla:silla, entrada: entrada)),
            ),
           
            SizedBox(height: 30,),
      
            MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.black,
                onPressed: () async { 
                               
                  final image= await screenShotController.capture();        
                  
                  await saveAndShare(image!);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 25),
                  child: Text('Compartir', 
                    style:  TextStyle(color: Colors.white),
                  ),
                )
                
                )
      
      
      
          ],
        ),
      ),
    );

     
  }

  Future saveAndShare(Uint8List bytes) async{
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/ticketCSH.png');
    image.writeAsBytesSync(bytes);
    await Share.shareXFiles([XFile(image.path)]);
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