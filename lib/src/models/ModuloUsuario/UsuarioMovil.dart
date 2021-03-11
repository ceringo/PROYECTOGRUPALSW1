import 'dart:convert';

UsuarioMovil usuarioMovilFromJson(Map str) => UsuarioMovil.fromJson(str);

String usuarioMovilToJson(UsuarioMovil data) => json.encode(data.toJson());

class UsuarioMovil {
  int id;
  String foto;
  String nombre;
  String apellidos;
  String telefono;
  String sexo;
  String fechaNacimiento;
  String fechaRegistro;
  String estado;

  UsuarioMovil({
    this.id,
    this.foto,
    this.nombre,
    this.apellidos,
    this.telefono,
    this.sexo,
    this.fechaNacimiento,
    this.fechaRegistro,
    this.estado,
  });

  factory UsuarioMovil.fromJson(Map<String, dynamic> json) => UsuarioMovil(
        id: json["id"],
        foto: json["foto"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        telefono: json["telefono"],
        sexo: json["sexo"],
        fechaNacimiento: json["fecha_nacimiento"],
        fechaRegistro: json["fecha_registro"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "foto": foto,
        "nombre": nombre,
        "apellidos": apellidos,
        "telefono": telefono,
        "sexo": sexo,
        "fecha_nacimiento": fechaNacimiento,
        "fecha_registro": fechaRegistro,
        "estado": estado,
      };
}
