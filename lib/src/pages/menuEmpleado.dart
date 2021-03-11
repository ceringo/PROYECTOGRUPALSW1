import 'package:flutter/material.dart';
import 'package:working/global.dart' as global;
import 'package:working/src/ia/imagen_IA.dart';
import 'package:working/src/models/ModuloServicio/Servicio.dart';
import 'package:working/src/pages/Empleado/detalle_solicitud.dart';
import 'package:working/src/pages/Empleado/publicacion_page.dart';
import 'package:working/src/pages/Empleado/solicitud_empleador_page.dart';
import 'package:working/src/pages/Empleado/contrato_empleador_page.dart';
import 'package:working/src/pages/Respaldo/respaldo_page.dart';
import 'package:working/src/pages/Trabajo/areas_page.dart';
import 'package:working/src/pages/Trabajo/contratos_page.dart';
import 'package:working/src/pages/Trabajo/mapa_empleado_page.dart';
import 'package:working/src/pages/Trabajo/servicios_page.dart';
import 'package:working/src/providers/request.dart' as req;

class MenuLateralEmpleado extends StatefulWidget {
  final List<Servicio> servicio;

  MenuLateralEmpleado({Key key, this.servicio}) : super(key: key);

  @override
  _MenuLateralEmpleadoState createState() => _MenuLateralEmpleadoState();
}

class _MenuLateralEmpleadoState extends State<MenuLateralEmpleado> {
  @override
  Widget build(BuildContext context) {
    return _menuLateralEmpleado(context);
  }

  Widget _menuLateralEmpleado(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) => Column(
                  children: <Widget>[
                    Divider(height: 10.0),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          global.PERSONA.foto,
                        ),
                        maxRadius: 30.0, //colocar la imagen del usuario
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              global.PERSONA.nombre +
                                  ' ' +
                                  global.PERSONA.apellidos,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, 'info');
                      },
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                global.EMPLEADO
                    ? Text("Modo : Empleador - Contratador")
                    : Text("Modo : Empleado - Trabajador"),
              ],
            ),
            Divider(height: 5.0),
            global.EMPLEADO == false
                ? Stack(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SolicitudParaAceptar()));
                        },
                        title: Text("Solicitudes"),
                        trailing: Icon(
                          Icons.notification_important,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  )
                : Text(""),
            global.EMPLEADO
                ? Divider(height: 0.0)
                : Stack(
                    children: <Widget>[
                      ListTile(
                        title: Text("Mi Trabajo"),
                        trailing: Icon(
                          Icons.work,
                          color: Colors.deepPurple,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContratoEnEjecucion()));
                        },
                      ),
                    ],
                  ),
            Divider(height: 5.0),
            global.EMPLEADO
                ? Divider(height: 0.0)
                : Stack(
                    children: <Widget>[
                      ListTile(
                        title: Text("Mis Servicios"),
                        trailing: Icon(
                          Icons.perm_device_information,
                          color: Colors.deepPurple,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ServicioPage()));
                        },
                      ),
                    ],
                  ),
            Divider(height: 5.0),
            global.EMPLEADO
                ? Stack(
                    children: <Widget>[
                      ListTile(
                        title: Text("Contratar"),
                        trailing: Icon(
                          Icons.create,
                          color: Colors.deepPurple,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AreasPage()));
                        },
                      ),
                    ],
                  )
                : Stack(
                    children: <Widget>[
                      ListTile(
                          title: Text("Publicidad"),
                          trailing: Icon(
                            Icons.public,
                            color: Colors.deepPurple,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PublicacionPage()))),
                    ],
                  ),
            global.EMPLEADO
                ? Stack(
                    children: <Widget>[
                      ListTile(
                          title: Text("Contrato Rapido"),
                          trailing: Icon(
                            Icons.camera_alt,
                            color: Colors.deepPurple,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TfliteHome()))),
                    ],
                  )
                : Divider(
                    height: 0.0,
                  ),
            Divider(height: 5.0),
            global.EMPLEADO
                ? Stack(
                    children: <Widget>[
                      ListTile(
                        title: Text("Mis Contratos"),
                        trailing: Icon(
                          Icons.create,
                          color: Colors.deepPurple,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MisContratosPage()));
                        },
                      ),
                    ],
                  )
                : Divider(
                    height: 0.0,
                  ),
            Divider(height: 5.0),
            ListTile(
              title: Text("Cerrar"),
              trailing: Icon(
                Icons.close,
                color: Colors.deepPurple,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(height: 30.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: global.EMPLEADO
                  ? RaisedButton(
                      child: Text("Modo Trabajador"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 0.0,
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          global.EMPLEADO = !global.EMPLEADO;
                          _deshabilitar("empleado");
                        });
                      },
                    )
                  : RaisedButton(
                      child: Text("Modo Contratador"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 0.0,
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          global.EMPLEADO = !global.EMPLEADO;
                          _deshabilitar("empleador");
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _deshabilitar(String accion) async {
    await req.Peticion()
        .habilitarEmpleado(global.PERSONA.id.toString(), accion);
  }
}
