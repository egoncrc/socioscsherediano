import 'package:flutter/material.dart';
import 'package:socioscsherediano/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
   
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
           child: LoginBackground(),
        ),
      ),
    );
  }
}