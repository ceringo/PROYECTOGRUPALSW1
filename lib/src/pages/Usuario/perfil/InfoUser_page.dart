import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:working/global.dart' as global;

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Informacion de contacto"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _fotoUsuario(),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
            _nombreUsuario(),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
            _apellidoUsuario(),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
            _telefonoUsuario(),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
            _sexoUsuario(),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
            _fechaUsuario(),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
            _tipoUsuario(),
            Padding(padding: const EdgeInsets.only(top: 100.0)),
            _botones(),
          ],
        ),
      ),
    );
  }
Widget _tipoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Tipo : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(global.EMPLEADO?"Empleado":"Empleador")
      ],
    );
  }

  Widget _fechaUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Fecha de Nacimiento : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(global.PERSONA.fechaNacimiento)
      ],
    );
  }

  Widget _sexoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Sexo : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(global.PERSONA.sexo)
      ],
    );
  }

  Widget _telefonoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Telefono : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(global.PERSONA.telefono)
      ],
    );
  }

  Widget _botones() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              "EDITAR",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blueAccent,
            onPressed: () {},
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              "ELIMINAR",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.redAccent,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _apellidoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Apellido : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(global.PERSONA.apellidos)
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
        Text(global.PERSONA.nombre)
      ],
    );
  }

  Widget _fotoUsuario() {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(top: 40.0)),
        Center(
          child: Image.network(
            global.PERSONA.foto.toString(),
            height: 150.0,
            width: 150.0,
          ),
        ),
      ],
    );
  }
}
