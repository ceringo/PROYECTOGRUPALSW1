// To parse this JSON data, do
//
//     final misContratos = misContratosFromJson(jsonString);

import 'dart:convert';

MisContratos misContratosFromJson(String str) =>
    MisContratos.fromJson(json.decode(str));

String misContratosToJson(MisContratos data) => json.encode(data.toJson());

class MisContratos {
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
  int idSolicitudContrato;
  String latitudEmpleador;
  String longitudEmpleador;
  DateTime fecha;
  String estadoSolicitud;
  int idEmpleador;
  int idServicio;
  int idEmpleado;
  int calificacionEmpleado;
  String descripcion;
  String precioEstandar;
  String especialidad;
  String correo;

  MisContratos({
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
    this.idSolicitudContrato,
    this.latitudEmpleador,
    this.longitudEmpleador,
    this.fecha,
    this.estadoSolicitud,
    this.idEmpleador,
    this.idServicio,
    this.idEmpleado,
    this.calificacionEmpleado,
    this.descripcion,
    this.precioEstandar,
    this.especialidad,
    this.correo,
  });

  factory MisContratos.fromJson(Map<String, dynamic> json) => MisContratos(
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
        idSolicitudContrato: json["id_solicitud_contrato"],
        latitudEmpleador: json["latitud_empleador"],
        longitudEmpleador: json["longitud_empleador"],
        fecha: DateTime.parse(json["fecha"]),
        estadoSolicitud: json["estado_solicitud"],
        idEmpleador: json["id_empleador"],
        idServicio: json["id_servicio"],
        idEmpleado: json["id_empleado"],
        calificacionEmpleado: json["calificacion_empleado"],
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
        "id_solicitud_contrato": idSolicitudContrato,
        "latitud_empleador": latitudEmpleador,
        "longitud_empleador": longitudEmpleador,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "estado_solicitud": estadoSolicitud,
        "id_empleador": idEmpleador,
        "id_servicio": idServicio,
        "id_empleado": idEmpleado,
        "calificacion_empleado": calificacionEmpleado,
        "descripcion": descripcion,
        "precio_estandar": precioEstandar,
        "especialidad": especialidad,
        "correo": correo,
      };
}
