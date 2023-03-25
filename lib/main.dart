import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socioscsherediano/pages/pages.dart';
import 'package:socioscsherediano/services/services.dart';
import 'package:socioscsherediano/share_preferences/preferences.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const AppState());
} 

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
            ChangeNotifierProvider(create: (_)=> AuthService()),
            ChangeNotifierProvider(create: (_)=> EntradaService()),
            ChangeNotifierProvider(create: (_)=> UserService()),
            
      ],
      child: MyApp(),
      );
  }
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socios Club Sport Herediano',
      initialRoute: 'login',
      routes: {
        //'ckecking': (_)=>const CheckAuthScreen(),
        'home': (_)=>const HomePage(),
        'login': (_)=>const LoginPage(),
        
        
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 239, 223, 143),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color.fromRGBO(120, 120, 120, 1),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.grey,
          elevation: 0
          )
      ),
    );
  }
}