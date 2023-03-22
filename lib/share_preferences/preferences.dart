

import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

  static late SharedPreferences _prefs;

  static String _correo='';
  static String _clave='';
  static bool _isSaveCredentials=false;

  static Future init() async{
    _prefs = await  SharedPreferences.getInstance();
  }

  static String get correo{
    return _prefs.getString('correo') ?? _correo;
  }

  static set correo (String value) {
    isSaveCredentials ?_correo = value : _correo = '';
    _prefs.setString('correo', value);
  }

  static String get clave{
    return _prefs.getString('clave') ?? _clave;
  }

  static set clave (String value) {
    isSaveCredentials ? _clave = value : _clave = '';
    _prefs.setString('clave', value);
  }

  static bool get isSaveCredentials{
    return _prefs.getBool('isSaveCredentials') ?? _isSaveCredentials;
  }

  static set isSaveCredentials (bool value) {
    _isSaveCredentials = value;
    _prefs.setBool('isSaveCredentials', value);
  }


}