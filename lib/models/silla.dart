import 'dart:convert';

class Silla {
    Silla({
        required this.numero,
    });

    String numero;

    factory Silla.fromJson(String str) => Silla.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Silla.fromMap(Map<String, dynamic> json) => Silla(
        numero: json["numero"],
    );

    Map<String, dynamic> toMap() => {
        "numero": numero,
    };
}