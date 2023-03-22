import 'dart:convert';
import 'package:socioscsherediano/models/models.dart';

class Juego {
    Juego({
        required this.jornada,
        required this.fecha,
        required this.hora,
        required this.equipo,
        required this.estadio,
    });

    int jornada;
    DateTime fecha;
    String hora;
    Zona equipo;
    Estadio estadio;

    factory Juego.fromJson(String str) => Juego.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Juego.fromMap(Map<String, dynamic> json) => Juego(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        equipo: Zona.fromMap(json["equipo"]),
        estadio: Estadio.fromMap(json["estadio"]),
    );

    Map<String, dynamic> toMap() => {
        "jornada": jornada,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "equipo": equipo.toMap(),
        "estadio": estadio.toMap(),
    };
}