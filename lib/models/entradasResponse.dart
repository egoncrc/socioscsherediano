import 'dart:convert';

import 'package:socioscsherediano/models/models.dart';

class EntradasResponse {
    EntradasResponse({
        required this.data,
    });

    List<Entrada> data;

    factory EntradasResponse.fromJson(String str) => EntradasResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EntradasResponse.fromMap(Map<String, dynamic> json) => EntradasResponse(
        data: List<Entrada>.from(json["data"].map((x) => Entrada.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}