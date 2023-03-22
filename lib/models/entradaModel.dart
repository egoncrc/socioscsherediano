import 'dart:convert';



class EntradaModel {
    EntradaModel({
        this.id,        
        required this.socio,
        required this.jornada,
        required this.fecha,
        required this.hora,
        required this.equipo,
        required this.estadio,
        // required this.idzona,
        required this.zona,
        required this.silla,
        required this.entrada,
        
    });

    int?   id;
    String socio;
    int jornada;
    String fecha;
    String hora;
    String equipo;
    String estadio;
    // int    idzona;
    String zona;
    String silla;
    String entrada;
    

    factory EntradaModel.fromJson(Map<String, dynamic> json) => EntradaModel(
        id: json["id"],
        socio: json["socio"],
        jornada: json["jornada"],
        fecha: json["fecha"],
        hora: json["hora"],
        equipo: json["equipo"],
        estadio: json["estadio"],
        // // idzona: json["idzona"],
        zona: json["zona"],
        silla: json["silla"],
        entrada: json["entrada"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "socio":socio ,
        "jornada":jornada ,
        "fecha":fecha ,
        "hora":hora ,
        "equipo":equipo ,
        "estadio":estadio ,
        // "idzona":idzona ,
        "zona":zona ,
        "silla":silla ,
        "entrada":entrada ,
    };
}

EntradaModel entradaModelFromJson(String str) => EntradaModel.fromJson(json.decode(str));

String entradaModelToJson(EntradaModel data) => json.encode(data.toJson());