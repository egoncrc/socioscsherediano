

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socioscsherediano/providers/login_form_provider.dart';
import 'package:socioscsherediano/services/services.dart';
import 'package:socioscsherediano/share_preferences/preferences.dart';
import 'package:socioscsherediano/ui/inpud_decoration.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: cardContainerDecoration(),
        child: Column(
                  children: [                    
                    Text('LOGIN', style: TextStyle(color: Color.fromARGB(188, 67, 60, 60),fontWeight: FontWeight.bold, fontSize:18)),
                    const SizedBox(height:10),
                    
                    ChangeNotifierProvider(
                      create: (_)=> LoginFormProvider(),
                      child: const _LoginForm(),                      
                    ),
        
                  ],
                ),
      ),
    );
  }

  BoxDecoration cardContainerDecoration() => BoxDecoration(
    //color: Colors.grey[200],
    
    borderRadius: BorderRadius.circular(30),
    // boxShadow: [
    //   BoxShadow(
    //     color: Colors.black26,
    //     blurRadius:15,
    //     offset:Offset(0,5)
        
    //     )
    // ]

  );
  
  
}


class _LoginForm extends StatelessWidget {
    const _LoginForm({super.key});
  
    @override
    Widget build(BuildContext context) {

      //final loginForm = Provider.of<LoginFormProvider>(context);
      final loginForm = context.watch<LoginFormProvider>();
      final userService = context.watch<UserService>();
      
    

      return Container(
        child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                initialValue: Preferences.correo,
                //keyboardType: TextInputType.emailAddress,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Número de Socio',
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icons.perm_identity_outlined
                ),
                onChanged: (value) {
                  Preferences.correo=value;
                  loginForm.email = value;
                },
                // validator: (value) {
                //   return EmailValidator.validate(value ?? '')
                //   ?  null
                //   : 'Por favor digite un correo válido';
                // },
                validator: (value) {
                  value ??= '0';
                  return (double.tryParse(value) != null && value.length >=5)
                  ?  null
                  : 'Por favor digite un socio válido';
                },

              ),
              const SizedBox(height:10),
              TextFormField(
                initialValue: Preferences.clave,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Contraseña',
                  labelText: 'Clave',
                  prefixIcon: Icons.lock_outline_rounded
                ),
                onChanged: (value) {
                  Preferences.clave=value;
                  loginForm.password = value;
                } ,
                validator: (value) {
                  return (value != null && value.length >=6) 
                  ? null
                  : 'Por favor digite una clave de 6 caracteres mínimo';
                },
              ),
              const SizedBox(height:20),
               Padding(
                 padding: const EdgeInsets.only(right:8.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                    
                    const Text('Guardar Credenciales'),

                    CupertinoSwitch(
                      value: loginForm.isSaveCredentials, 
                      onChanged: (value){
                        loginForm.isSaveCredentials =value;
                      },
                      activeColor: Colors.black87,
                    )
                   ],
                  ),
               ),
              const SizedBox(height:20),

              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.black,
                onPressed: loginForm.isLoading? null:() async {
                  //Quita el teclado de la pantalla
                  FocusScope.of(context).unfocus();

                   final authService = context.read<AuthService>();
                   

                   if(!loginForm.isValidForm()) return;
                   loginForm.isLoading =true;  

                   final String? errorMessage =await authService.login(loginForm.email, loginForm.password);

                   if(errorMessage ==null){
                     await userService.userMe(); 
                     if(!Preferences.isSaveCredentials){
                      Preferences.correo = '';
                      Preferences.clave = '';
                     }


                     // ignore: use_build_context_synchronously
                     Navigator.pushReplacementNamed(context, 'home');

                   }else{                     
                     String errorCredenciales='';
                     if(errorMessage =='Invalid user credentials.'){
                      errorCredenciales = 'Usuario y/o Clave Incorrectos';
                     }
                     NotificationsService.showSnackBar(errorCredenciales);
                     loginForm.isLoading =false;
                   }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                  child: Text(
                    loginForm.isLoading
                    ? 'Espere...' : 'INGRESAR', 
                    style: const TextStyle(color: Colors.white, fontSize:11),
                  ),
                )
                
                )
            ],
          ),
        ),
      );
    }
}