import 'dart:convert';

class Estadio {
    Estadio({
        required this.nombre,
    });

    String nombre;

    factory Estadio.fromJson(String str) => Estadio.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Estadio.fromMap(Map<String, dynamic> json) => Estadio(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
    };
}