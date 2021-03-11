// To parse this JSON data, do
//
//     final empleadosIAa = empleadosIAaFromJson(jsonString);

import 'dart:convert';

EmpleadosIA empleadosIAFromJson(String str) =>
    EmpleadosIA.fromJson(json.decode(str));

String empleadosIAToJson(EmpleadosIA data) => json.encode(data.toJson());

class EmpleadosIA {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String foto;
  String nombre;
  String apellidos;
  String telefono;
  String sexo;
  DateTime fechaNacimiento;
  DateTime fechaRegistro;
  String estado;
  int idLogin;
  String latitud;
  String longitud;
  int idUsuarioMovil;
  int idEmpleado;
  int calificacionEmpleado;
  int idServicio;
  String descripcion;
  String precioEstandar;
  String especialidad;
  String correo;

  EmpleadosIA({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.foto,
    this.nombre,
    this.apellidos,
    this.telefono,
    this.sexo,
    this.fechaNacimiento,
    this.fechaRegistro,
    this.estado,
    this.idLogin,
    this.latitud,
    this.longitud,
    this.idUsuarioMovil,
    this.idEmpleado,
    this.calificacionEmpleado,
    this.idServicio,
    this.descripcion,
    this.precioEstandar,
    this.especialidad,
    this.correo,
  });

  factory EmpleadosIA.fromJson(Map<String, dynamic> json) => EmpleadosIA(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        foto: json["foto"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        telefono: json["telefono"],
        sexo: json["sexo"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
        estado: json["estado"],
        idLogin: json["id_login"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        idUsuarioMovil: json["id_usuario_movil"],
        idEmpleado: json["id_empleado"],
        calificacionEmpleado: json["calificacion_empleado"],
        idServicio: json["id_servicio"],
        descripcion: json["descripcion"],
        precioEstandar: json["precio_estandar"],
        especialidad: json["especialidad"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "foto": foto,
        "nombre": nombre,
        "apellidos": apellidos,
        "telefono": telefono,
        "sexo": sexo,
        "fecha_nacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "fecha_registro":
            "${fechaRegistro.year.toString().padLeft(4, '0')}-${fechaRegistro.month.toString().padLeft(2, '0')}-${fechaRegistro.day.toString().padLeft(2, '0')}",
        "estado": estado,
        "id_login": idLogin,
        "latitud": latitud,
        "longitud": longitud,
        "id_usuario_movil": idUsuarioMovil,
        "id_empleado": idEmpleado,
        "calificacion_empleado": calificacionEmpleado,
        "id_servicio": idServicio,
        "descripcion": descripcion,
        "precio_estandar": precioEstandar,
        "especialidad": especialidad,
        "correo": correo,
      };
}
