import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:socioscsherediano/pages/pages.dart';
import 'package:socioscsherediano/pages/views/views.dart';
import 'package:socioscsherediano/services/services.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final entradaService = context.read<EntradaService>();
    entradaService.loadEntradas();    
    final userService = context.read<UserService>();
  
    
    
    return  Scaffold(
      
      appBar: AppBar(
        title: Text('Socio(a): ${userService.nombreSocio}', style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.bold, fontSize:18)),
        actions: [IconButton(
                    icon: Icon(Icons.login_outlined, color: Colors.white),
                    onPressed: (){
                      authService.logout();
                      userService.nombreSocio='';
                      Navigator.pushReplacementNamed(context,'login');
                    },
                  ),
                ],
      ),
      body: PersistentTabView(
        context, 
        screens: views(),
        items: navBarItems(),
        navBarStyle: NavBarStyle.style3,

      ),
    );
  }

  List<Widget> views(){
    return [
      TicketListView(),
      
      CalendarListView()
    ];
  }
  
  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.qr_code_2_outlined),
        title: "Entradas", 
        activeColorPrimary: Color.fromARGB(255, 243, 68, 56),
        inactiveColorPrimary: CupertinoColors.systemGrey
        ),

      

      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_month_outlined),
        title: "Jornadas", 
        activeColorPrimary: Color.fromARGB(255, 243, 68, 56),
        inactiveColorPrimary: CupertinoColors.systemGrey
        ),

      
      
    ];
  }
}