import 'dart:convert';

class Zona {
    Zona({
        required this.nombre,
    });

    String nombre;

    factory Zona.fromJson(String str) => Zona.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Zona.fromMap(Map<String, dynamic> json) => Zona(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
    };
}