import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;



class AuthService extends ChangeNotifier{

  final String _baseUrl ='http://161.22.47.35:8055';

  final storage= const FlutterSecureStorage();




  //****************LOGIN USUARIO*****************/
   Future<String?> login(String email, String password) async{
      String numeroSocio = '$email@socioscsherediano.com';
      final Map<String,dynamic> authData ={
        "email": numeroSocio,
	      "password": password
	      
      };
      

      final url = Uri.parse('$_baseUrl/auth/login');
      final headers = <String, String>{"Content-type": "application/json; charset=UTF-8"};
      final resp= await http.post(url, headers: headers, body: json.encode(authData));
      final Map<String,dynamic> decodedData = json.decode(resp.body);
      //print(decodedData);
      
      if(decodedData.containsKey('data')){
         //print(decodedData['data']['id']);
        //  print(decodedData['data']['access_token']);
        await storage.write(key: 'token', value: decodedData['data']['access_token']);
               
        return null;
      }else if(decodedData.containsKey('errors')) {
        //  print (decodedData['errors'][0]['message']);
         return decodedData['errors'][0]['message'];

      }

  }

  //**********************LOGOUT************************/
  Future logout() async{
    await storage.delete(key: 'token');
    // await storage.delete(key: 'socio');
    return;
  }

  //*************LEER TOKEN************************/
  Future<String> readToken() async{
    return await storage.read(key:'token') ?? '';
  }

}