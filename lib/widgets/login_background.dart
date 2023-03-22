import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socioscsherediano/widgets/widgets.dart';


class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(49,157,198, 1),
      child: Stack(
        children: [
          
            _HeaderBox(),            
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height:400),
                  ContainerCard(),
                  
                  SizedBox(height: 10,),
                  Row(                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿Olvidó su contraseña?',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),),
                      TextButton(
                      onPressed: ()=> Navigator.pushReplacementNamed(context, 'register'),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder())
                      ),
                      child: Text('PRESIONE AQUÍ',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red),),
                      
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
            
          //  _HeaderIcon(),
          //  child,
        ],
      ),
    );
  }
}

class _HeaderBox extends StatelessWidget {
  const _HeaderBox({super.key});

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return Container(
        width: double.infinity,
        height: size.height,
        decoration: _headerBackgroundDecoration(),
        child: Stack(
          children: [            
            Center(
              child: Column(
                children: [
                  Image(image: AssetImage('assets/garragris.png'),height:340,),
                ],
              ),
            ),
            Center(child: Column(
              children: [
                SizedBox(height: 55,),
                Padding(
                  padding: const EdgeInsets.only(right: 55, left: 55),
                  child: Column(                    
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                          Image(image: AssetImage('assets/escudo.png'),height:size.height * 0.20,), 
                          SizedBox(height: 40,),                     
                          Text('SOCIOS', style: GoogleFonts.abrilFatface(color: Colors.white, fontSize:24, fontWeight:FontWeight.bold)),
                          SizedBox(height: 10,),
                          Text('C.S. HEREDIANO', style: GoogleFonts.abrilFatface(color: Colors.white, fontSize:24, fontWeight:FontWeight.bold),),
                          SizedBox(height: 10,),
                       
                      
                  
                    ],
                  ),
                ),
                
              ],
            ))
          ],
        ),
      );
  }

  BoxDecoration _headerBackgroundDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(139,142,150,1),
        // Color.fromRGBO(21,176,179, 1),
        Color.fromRGBO(232,230,228,1)
      ]
      )
  );

}


