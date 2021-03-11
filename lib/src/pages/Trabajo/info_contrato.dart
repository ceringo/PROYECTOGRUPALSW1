import 'package:flutter/material.dart';
import 'package:working/src/providers/request.dart' as req;
import 'package:working/global.dart' as global;
import 'package:working/src/models/ModuloTrabajo/MisContratos.dart';

class InfoContrato extends StatelessWidget {
  final MisContratos empleados;
  final String accion;

  InfoContrato({Key key, this.empleados, this.accion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Informacion de " + empleados.nombre),
            centerTitle: true,
            leading: IconButton(
              tooltip: 'Previous choice',
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _fotoUsuario(),
              _calificacionUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _nombreUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _apellidoUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _telefonoUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _precioUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _correoUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _fechaUsuario(),
              Padding(padding: const EdgeInsets.only(top: 30.0)),
              _epecialidadUsuario(),
              Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: accion == "enespera"
                      ? RaisedButton(
                          color: Colors.red,
                          onPressed: () {
                            _alerta(context, "Seguro que quieres dar de Baja?",
                                "debaja");
                          },
                          child: Text("Dar Baja"),
                        )
                      : Text(""))
            ],
          ),
        ));
  }

  _alerta(BuildContext context, String value, String accion) {
    AlertDialog dialog = new AlertDialog(
      content: Text(value,
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).primaryColor,
          )),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              req.Peticion().accionSolicitudContrato(
                  global.PERSONA.id.toString(), accion);
              Navigator.pushReplacementNamed(context, 'home');
            },
            child: Text("SI")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("NO")),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }

  Widget _fechaUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Solicitud : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.fecha.toString().substring(0, 11))
      ],
    );
  }

  Widget _epecialidadUsuario() {
    return Text(empleados.especialidad,
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold));
  }

  Widget _calificacionUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Calificacion : ",
          style: TextStyle(fontSize: 24.0),
        ),
        _crearEstrella(empleados.calificacionEmpleado),
      ],
    );
  }

  _crearEstrella(int longitud) {
    if (longitud == 1) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      );
    } else if (longitud == 2) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      );
    } else if (longitud == 3) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      );
    } else if (longitud == 4) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star),
        ],
      );
    } else if (longitud == 5) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      );
    }
  }

  Widget _telefonoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Telefono : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.telefono)
      ],
    );
  }

  Widget _correoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Correo : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.correo)
      ],
    );
  }

  Widget _precioUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Precio : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.precioEstandar + ' ' + 'Bs')
      ],
    );
  }

  Widget _apellidoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Apellido : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.apellidos)
      ],
    );
  }

  Widget _nombreUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Nombre : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.nombre)
      ],
    );
  }

  Widget _fotoUsuario() {
    return Column(
      children: <Widget>[
        // Padding(padding: const EdgeInsets.only(top: 10.0)),
        Center(
          child: Image.network(
            empleados.foto.toString(),
            height: 250.0,
            width: 250.0,
          ),
        ),
      ],
    );
  }
}
