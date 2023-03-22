import 'dart:convert';

import 'package:socioscsherediano/models/models.dart';

class Zonasilla {
    Zonasilla({
        required this.zona,
        required this.silla,
    });

    Zona zona;
    Silla silla;

    factory Zonasilla.fromJson(String str) => Zonasilla.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Zonasilla.fromMap(Map<String, dynamic> json) => Zonasilla(
        zona: Zona.fromMap(json["zona"]),
        silla: Silla.fromMap(json["silla"]),
    );

    Map<String, dynamic> toMap() => {
        "zona": zona.toMap(),
        "silla": silla.toMap(),
    };
}