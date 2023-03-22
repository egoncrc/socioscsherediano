import 'dart:convert';
import 'package:socioscsherediano/models/models.dart';

class Membresia {
    Membresia({
        required this.id,
        required this.zonasilla,
        required this.socio,
    });

    int id;
    Zonasilla zonasilla;
    Socio socio;

    factory Membresia.fromJson(String str) => Membresia.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Membresia.fromMap(Map<String, dynamic> json) => Membresia(
        id: json["id"],
        zonasilla: Zonasilla.fromMap(json["zonasilla"]),
        socio: Socio.fromMap(json["socio"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "zonasilla": zonasilla.toMap(),
        "socio": socio.toMap(),
    };
}