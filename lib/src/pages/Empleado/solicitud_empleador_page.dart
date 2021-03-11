import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloEmpleado/Soliciudes.dart';
import 'package:working/src/pages/Empleado/contratos_page.dart';
//get location
import 'package:location/location.dart';
import 'package:flutter/services.dart';




import 'package:working/src/providers/request.dart' as req;
import 'package:working/global.dart' as global;
import 'package:working/src/pages/Empleado/detalle_solicitud.dart';

class SolicitudParaAceptar extends StatefulWidget {
  @override
  _SolicitudParaAceptarState createState() => _SolicitudParaAceptarState();
}

class _SolicitudParaAceptarState extends State<SolicitudParaAceptar> {
  List<Solicitudes> _listaSolicitudes = new List();
  _cargarSolicitudes() async {
    List<Solicitudes> lista =
        await req.Peticion().misSolicitudes(global.PERSONA.id.toString());
    setState(() {
      _listaSolicitudes.addAll(lista);
    });
  }

  @override
  void initState() {
    super.initState();
    _cargarSolicitudes();
  }

  Future<Null> _refresh() async {
    Future.delayed(Duration(seconds: 10));
    setState(() {
      _cargarSolicitudes();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solicitudes"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          child: ListView.builder(
            itemCount: _listaSolicitudes.length,
            itemBuilder: (context, index) {
              Solicitudes data = _listaSolicitudes[index];
              return Card(
                child: ListTile(
                  leading: Container(
                      height: 100.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data.foto)))),
                  title: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      data.especialidad,
                      style: TextStyle(
                          fontSize: 19.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Column(children: <Widget>[
                    Text(
                      data.nombre + ' ' + data.apellidos,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "Fecha : " + data.fecha.toString().substring(0, 11),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      size: 50.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detalleSolicitud(
                                  solicitud: _listaSolicitudes[index])));
                    },
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
