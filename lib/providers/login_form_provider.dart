import 'package:flutter/material.dart';
import 'package:socioscsherediano/share_preferences/preferences.dart';

class LoginFormProvider extends ChangeNotifier{
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  bool _isSaveCredentials = false;

  String get email{
    
    if(Preferences.correo.isNotEmpty){
      _email =Preferences.correo;
    }
    notifyListeners();
    return  _email;
  } 

  set email(String value) {
    _email = value;    
    notifyListeners();
  }

  String get password {
    if(Preferences.clave.isNotEmpty){
      _password =Preferences.clave;
    }
    notifyListeners();
    return _password;
  } 
  set password(String value) {
    _password = value;
    notifyListeners();
  }


  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isSaveCredentials{
    return Preferences.isSaveCredentials ? Preferences.isSaveCredentials : _isSaveCredentials;
  } 
  set isSaveCredentials(bool value) {
    _isSaveCredentials = value;
    Preferences.isSaveCredentials = value;
    notifyListeners();
  }


  bool isValidForm(){

    //print(formKey.currentState?.validate());
    //print('${email} - ${password}');
    return formKey.currentState?.validate() ?? false;
  }


}