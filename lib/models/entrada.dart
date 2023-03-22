import 'dart:convert';

import 'package:socioscsherediano/models/models.dart';

class Entrada {
    Entrada({
        required this.entrada,
        required this.juego,
        required this.membresia,
    });

    String entrada;
    Juego juego;
    Membresia membresia;

    factory Entrada.fromJson(String str) => Entrada.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Entrada.fromMap(Map<String, dynamic> json) => Entrada(
        entrada: json["entrada"],
        juego: Juego.fromMap(json["juego"]),
        membresia: Membresia.fromMap(json["membresia"]),
    );

    Map<String, dynamic> toMap() => {
        "entrada": entrada,
        "juego": juego.toMap(),
        "membresia": membresia.toMap(),
    };
}