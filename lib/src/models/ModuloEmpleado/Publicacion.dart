
import 'dart:convert';

Publicacion publicacionFromJson(String str) => Publicacion.fromJson(json.decode(str));

String publicacionToJson(Publicacion data) => json.encode(data.toJson());

class Publicacion {
    String idEmplead;
    String titulo;
    String descripcion;
    int costo;
    int idTipo;

    Publicacion({
        this.idEmplead,
        this.titulo,
        this.descripcion,
        this.costo,
        this.idTipo,
    });

    factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
        idEmplead: json["id_emplead"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        costo: json["costo"],
        idTipo: json["id_tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id_emplead": idEmplead,
        "titulo": titulo,
        "descripcion": descripcion,
        "costo": costo,
        "id_tipo": idTipo,
    };
}
