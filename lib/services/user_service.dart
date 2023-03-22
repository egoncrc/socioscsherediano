
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;



class UserService extends ChangeNotifier{

  final String _baseUrl ='http://161.22.47.35:8055';
  final storage= const FlutterSecureStorage();
  String nombreSocio = '';


 


  //****************OBTIENE USUARIO ACTUAL*****************/
   Future userMe() async{
    final String _accessToken = await storage.read(key:'token') ?? '';
    
    
    
      final url = Uri.parse('$_baseUrl/users/me' );
      final headers = {"Content-type": "application/json", HttpHeaders.authorizationHeader: 'Bearer $_accessToken'};
      final resp= await http.get(url, headers: headers);
      final Map<String,dynamic> decodedData = json.decode(resp.body);
      //print(decodedData['data']['id']);
         
      nombreSocio= '${decodedData['data']['first_name']} ${decodedData['data']['last_name']}';
      notifyListeners();
      
      await storage.write(key: 'socio', value: decodedData['data']['id']); 
    
 }

  

}