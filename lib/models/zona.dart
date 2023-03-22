import 'dart:convert';

class Zona {
    Zona({
        required this.id,
        required this.nombre,
    });

    int id;
    String nombre;

    factory Zona.fromJson(String str) => Zona.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Zona.fromMap(Map<String, dynamic> json) => Zona(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
    };
}