import 'dart:convert';

Contrato contratoFromJson(Map str) => Contrato.fromJson(str);

String contratoToJson(Contrato data) => json.encode(data.toJson());

class Contrato {
    int id;
    String fechaInicio;
    String fechaFin;
    String latitudEmpleado;
    String longitudEmpleado;
    String latitudEmpleador;
    String longitudEmpleador;
    String calificacionEmpleado;
    String calificacionEmpleador;
    String estado;

    Contrato({
        this.id,
        this.fechaInicio,
        this.fechaFin,
        this.latitudEmpleado,
        this.longitudEmpleado,
        this.latitudEmpleador,
        this.longitudEmpleador,
        this.calificacionEmpleado,
        this.calificacionEmpleador,
        this.estado,
    });

    factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        id: json["id"],
        fechaInicio: json["fecha_inicio"],
        fechaFin: json["fecha_fin"],
        latitudEmpleado: json["latitud_empleado"],
        longitudEmpleado: json["longitud_empleado"],
        latitudEmpleador: json["latitud_empleador"],
        longitudEmpleador: json["longitud_empleador"],
        calificacionEmpleado: json["calificacion_empleado"],
        calificacionEmpleador: json["calificacion_empleador"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha_inicio": fechaInicio,
        "fecha_fin": fechaFin,
        "latitud_empleado": latitudEmpleado,
        "longitud_empleado": longitudEmpleado,
        "latitud_empleador": latitudEmpleador,
        "longitud_empleador": longitudEmpleador,
        "calificacion_empleado": calificacionEmpleado,
        "calificacion_empleador": calificacionEmpleador,
        "estado": estado,
    };
}
