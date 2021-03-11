// To parse this JSON data, do
//
//     final area = areaFromJson(jsonString);

import 'dart:convert';

Area areaFromJson(String str) => Area.fromJson(json.decode(str));

String areaToJson(Area data) => json.encode(data.toJson());

class Area {
  int id;
  String nombre;
  String descripcion;
  List<ListaEspecialidad> listaEspecialidad;

  Area({
    this.id,
    this.nombre,
    this.descripcion,
    this.listaEspecialidad,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        listaEspecialidad: List<ListaEspecialidad>.from(
            json["ListaEspecialidad"]
                .map((x) => ListaEspecialidad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "ListaEspecialidad":
            List<dynamic>.from(listaEspecialidad.map((x) => x.toJson())),
      };
}

class ListaEspecialidad {
  int id;
  String nombre;
  String descripcion;

  ListaEspecialidad({
    this.id,
    this.nombre,
    this.descripcion,
  });

  factory ListaEspecialidad.fromJson(Map<String, dynamic> json) =>
      ListaEspecialidad(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
      };
}
