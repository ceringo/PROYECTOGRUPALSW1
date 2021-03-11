// To parse this JSON data, do
//
//     final servicio = servicioFromJson(jsonString);

import 'dart:convert';

Servicio servicioFromJson(String str) => Servicio.fromJson(json.decode(str));

String servicioToJson(Servicio data) => json.encode(data.toJson());

class Servicio {
  int id;
  String descripcion;
  String precioEstandar;
  String estadoServicio;
  String nombre;

  Servicio({
    this.id,
    this.descripcion,
    this.precioEstandar,
    this.estadoServicio,
    this.nombre,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        id: json["id"],
        descripcion: json["descripcion"],
        precioEstandar: json["precio_estandar"],
        estadoServicio: json["estado_servicio"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "precio_estandar": precioEstandar,
        "estado_servicio": estadoServicio,
        "nombre": nombre,
      };
}
