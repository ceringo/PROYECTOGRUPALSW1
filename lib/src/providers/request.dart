import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:image/image.dart' as imag;

import 'package:working/global.dart';
import 'package:working/src/models/ModuloEmpleado/EmpleadoIA.dart';
import 'package:working/src/models/ModuloEmpleado/Soliciudes.dart';
import 'package:working/src/models/ModuloServicio/Area.dart';
import 'package:working/src/models/ModuloServicio/Servicio.dart';
import 'package:working/src/models/ModuloTrabajo/MisContratos.dart';
import 'package:working/src/models/ModuloUsuario/UsuarioMovil.dart';

class Peticion {
  Peticion();
  Future<dynamic> getJson(Uri url) async {
    http.Response response = await http.get(url);

    // if (response.statusCode == 200) {
    print(json.decode(response.body).toString());
    return json.decode(response.body);
    // return PlaceHolderModel.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to load');
    // }
  }

  Future<List<UsuarioMovil>> autenticando(String email, String pass) async {
    var uri = new Uri.http(
        API_URL, '/api/usuario/login', {'email': email, 'password': pass});
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<UsuarioMovil>((item) => UsuarioMovil.fromJson(item))
        .toList()));
  }

  Future<void> realizarSolicitudContrato(String latitud, String longitud,
      String id_empleador, String id_servicio) async {
    var uri = new Uri.http(API_URL, '/api/trabajo/crearsolicitudcontrato', {
      'latitud_empleador': latitud,
      'longitud_empleador': longitud,
      'id_usuario_movil': id_empleador,
      'id_servicio': id_servicio
    });
    print(uri.toString());
    await getJson(uri);
  }

  //actualizar ubicacion
  Future<void> guardarUbicacion(
    String id_empleador,
    String latitud,
    String longitud,
  ) async {
    var uri = new Uri.http(API_URL, '/api/trabajo/ubicacion', {
      'id_usuario_movil': id_empleador,
      'latitud': latitud,
      'longitud': longitud,
    });
    print(uri.toString());
    await getJson(uri);
  }

  Future<void> aceptarTrabajo(String latitud, String longitud,
      String id_solicitud, String id_servicio) async {
    var uri = new Uri.http(API_URL, '/api/trabajo/contratar', {
      'id_solicitud': id_solicitud,
      'id_servicio': id_servicio,
      'latitud_empleado': latitud,
      'longitud_empleado': longitud
    });
    print(uri.toString());
    await getJson(uri);
  }

  Future<List<EmpleadosIA>> contratoRapido(String objeto, String id) async {
    var uri = new Uri.http(API_URL, '/api/trabajo/iabusqueda',
        {'objeto': objeto, 'id_usuario_movil': id});
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<EmpleadosIA>((item) => EmpleadosIA.fromJson(item))
        .toList()));
  }

  Future<List<EmpleadosIA>> empleados(String id) async {
    var uri = new Uri.http(
        API_URL, '/api/trabajo/trabajadores', {'id_especialidad': id});
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<EmpleadosIA>((item) => EmpleadosIA.fromJson(item))
        .toList()));
  }

  Future<List<MisContratos>> misContratosEnEspera(
      String accion, String id) async {
    var uri = new Uri.http(API_URL, '/api/trabajo/listagenerica',
        {'id_usuario_movil': id, 'accion': accion});
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<MisContratos>((item) => MisContratos.fromJson(item))
        .toList()));
  }

////////para lassolicitudes que tiene como espera el usuario
  Future<List<Solicitudes>> misSolicitudes(String id) async {
    var uri = new Uri.http(
        API_URL,
        '/api/trabajo/listadesolicitudesparacontrato',
        {'id_usuario_movil': id});
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<Solicitudes>((item) => Solicitudes.fromJson(item))
        .toList()));
  }

  ////////para ver los contratos que tiene como espera el usuario
  Future<List<Solicitudes>> misContratos(String id) async {
    var uri = new Uri.http(
        API_URL, '/api/trabajo/listademiscontrato', {'id_usuario_movil': id});
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<Solicitudes>((item) => Solicitudes.fromJson(item))
        .toList()));
  }

  /////////OBTENIENDO AREAS Y ESPECIALIDADES
  Future<List<Area>> areas() async {
    var uri = new Uri.http(API_URL, '/api/trabajo/serviciocomplemento');
    print(uri.toString());
    return await getJson(uri).then(((data) =>
        data['data'].map<Area>((item) => Area.fromJson(item)).toList()));
  }

  Future<List<Area>> areasServicios() async {
    var uri = new Uri.http(API_URL, '/api/trabajo/areasservicios');
    print(uri.toString());
    return await getJson(uri).then(((data) =>
        data['data'].map<Area>((item) => Area.fromJson(item)).toList()));
  }

  Future<List<UsuarioMovil>> registrarUsuario(
      String nombre,
      String apellido,
      String email,
      String password,
      String telefono,
      String sexo,
      String fechaNacimiento,
      String imagen) async {
    var uri = new Uri.http(API_URL, 'api/usuario/registro', {
      'nombre': nombre,
      'apellidos': apellido,
      'correo': email,
      'pasword': password,
      'telefono': telefono,
      'sexo': sexo,
      'fecha_nacimiento': fechaNacimiento,
      'foto': imagen,
      'longitud': 'asdasd',
      'latitud': 'sdfcsdc',
    });
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<UsuarioMovil>((item) => UsuarioMovil.fromJson(item))
        .toList()));
  }

  Future<List<Servicio>> listarServicio(String id) async {
    var uri = new Uri.http(API_URL, 'api/trabajo/listamisservicios', {
      'id_usuario_movil': id,
    });
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<Servicio>((item) => Servicio.fromJson(item))
        .toList()));
  }

  Future<void> cambiarEstado(String id) async {
    var uri = new Uri.http(API_URL, 'api/trabajo/desabilitarservicio', {
      'id_servicio': id,
    });
    print(uri.toString());
    await getJson(uri);
  }

  Future<void> habilitarEmpleado(String id, String accion) async {
    var uri = new Uri.http(
        API_URL,
        'api/trabajo/habilitaredeshabilitarempleado',
        {'id_usuario_movil': id, 'accion': accion});
    print(uri.toString());
    await getJson(uri);
  }

  Future<void> cambiarEstadoAll(String id, String bandera) async {
    var uri = new Uri.http(API_URL, 'api/trabajo/alldesabilitarservicios', {
      'id_usuario_movil': id,
      'bandera': bandera,
    });
    print(uri.toString());
    await getJson(uri);
  }

  Future<List<Servicio>> servicio(
    String descripcion,
    String especialidad,
    String id_usuario,
    String precio,
  ) async {
    var uri = new Uri.http(API_URL, 'api/trabajo/crearservicio', {
      'descripcion': descripcion,
      'id_usuario_movil': id_usuario,
      'precio_estandar': precio,
      'nombre_especialidad': especialidad,
    });
    print(uri.toString());
    return await getJson(uri).then(((data) => data['data']
        .map<Servicio>((item) => Servicio.fromJson(item))
        .toList()));
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dwq72cog2/image/upload?upload_preset=lkpbycp7');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }

  Future<void> finalizarTrabajo(String id_servico) async {
    var uri = new Uri.http(
        API_URL, '/api/trabajo/finalizarcontrato', {'id_servicio': id_servico});
    print(uri.toString());
    await getJson(uri);
  }

  //Dar de baja solicitud de contrato

  Future<void> accionSolicitudContrato(String id_servico, String accion) async {
    var uri;

    if (accion == "debaja") {
      uri = new Uri.http(API_URL, '/api/trabajo/accionsolicitudcontrato',
          {'id_servicio': id_servico, 'accion': accion});
    }

    if (accion == "rechazado") {
      uri = new Uri.http(API_URL, '/api/trabajo/rechazarsolicitud',
          {'id_solicitud_contrato': id_servico});
    }

    print(uri.toString());
    await getJson(uri);
  }

  Future<void> crearPDF(List<File> lista, String nombre) async {
    /*var x=lista;
    print(x.toString());*/
    final pdf = Document();

    for (var file in lista) {
      final img = imag.decodeImage(file.readAsBytesSync());
      final image = PdfImage(
        pdf.document,
        image: img.data.buffer.asUint8List(),
        width: img.width,
        height: img.height,
      );

      pdf.addPage(Page(build: (Context context) {
        return Image(image); // Center
      })); //
    }
    final file = File("/storage/emulated/0/Pdf/$nombre.pdf");
    print("direccion de el archivo => " + file.toString());
    await file.writeAsBytes(pdf.save());

    //return subirImagen(pdf.save());
  }
}
