import 'dart:convert';

class Socio {
    Socio({
        required this.user,
    });

    String user;

    factory Socio.fromJson(String str) => Socio.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Socio.fromMap(Map<String, dynamic> json) => Socio(
        user: json["user"],
    );

    Map<String, dynamic> toMap() => {
        "user": user,
    };
}