import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:working/src/models/ModuloEmpleado/Publicacion.dart';

import 'package:working/src/providers/request.dart' as req;

class PublicacionCreate extends StatefulWidget {
  final String accion;
  PublicacionCreate({Key key, this.accion}) : super(key: key);

  @override
  _PublicacionCreateState createState() => _PublicacionCreateState();
}

class _PublicacionCreateState extends State<PublicacionCreate> {
  Publicacion publicacion = new Publicacion();
  File foto;
  String photo = "";

  @override
  Widget build(BuildContext context) {
    String ac = widget.accion;
    return Scaffold(
      appBar: AppBar(
        title: Text('$ac' + ' Publicacion'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: Container(
        color: Colors.deepPurpleAccent[50],
        padding: EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: _mostrarFoto(),
              ),
              _crearTitulo(),
              _crearDescripcion(),
              _crearCosto(),
              _crearCuenta(),
              _crearServicios(),
              _botones()
            ],
          ),
        ),
      ),
    );
  }

  Widget _botones() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              "Guardar",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blueAccent,
            onPressed: () {},
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.redAccent,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _crearServicios() {
    List<DropdownMenuItem<String>> listaDrop = [];
    listaDrop.add(
      DropdownMenuItem(
        child: Text("     Base de datos    "),
        value: "1",
      ),
    );
    listaDrop.add(
      DropdownMenuItem(
        child: Text("     Diseñador    "),
        value: "1",
      ),
    );
    listaDrop.add(DropdownMenuItem(
      child: Text("       Mantenimiento      "),
      value: "2",
    ));
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 24.0),
              child: Icon(
                Icons.touch_app,
                color: Colors.deepPurple,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              child: DropdownButton(
                items: listaDrop,
                hint: Text("     Servicios     "),
                onChanged: (value) {
                  setState(() {
                    publicacion.idTipo = value;
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget _crearCuenta() {
    List<DropdownMenuItem<String>> listaDrop = [];
    listaDrop.add(
      DropdownMenuItem(
        child: Text("     Premium    "),
        value: "1",
      ),
    );
    listaDrop.add(DropdownMenuItem(
      child: Text("       Normal      "),
      value: "2",
    ));
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 24.0),
              child: Icon(
                Icons.touch_app,
                color: Colors.deepPurple,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              child: DropdownButton(
                items: listaDrop,
                hint: Text("     Tipo de Cuenta     "),
                onChanged: (value) {
                  setState(() {
                    publicacion.idTipo = value;
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget _crearCosto() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.money_off,
                  color: Colors.deepPurple,
                ),
                hintText: '100.00',
                labelText: 'Costo',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (string) {
              setState(() {
                publicacion.costo = int.parse(string);
              });
            },
          ),
        );
      },
    );
  }

  Widget _crearDescripcion() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.description,
                  color: Colors.deepPurple,
                ),
                hintText:
                    'Se ofrece recuperacion de cuentas de cualquier tipo, etc',
                labelText: 'Descripcion',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (string) {
              setState(() {
                publicacion.descripcion = string;
              });
            },
          ),
        );
      },
    );
  }

  Widget _crearTitulo() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.title,
                  color: Colors.deepPurple,
                ),
                hintText: 'Servicios de Hacker',
                labelText: 'Titulo',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (string) {
              setState(() {
                publicacion.titulo = string;
              });
            },
          ),
        );
      },
    );
  }

  Widget _mostrarFoto() {
    if (photo != "") {
      return FadeInImage(
        image: NetworkImage(photo),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 250.0,
        fit: BoxFit.contain,
      );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/no-image.png'),
        height: 250.0,
        // width: 200.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    File img = await ImagePicker.pickImage(source: origen);
    setState(() {
      foto = img;
    });
    //_guardarImage();    //descomentar para guardar la imagen en la nube
  }

  _guardarImage() async {
    String url = await req.Peticion().subirImagen(foto);
    setState(() {
      photo = url;
    });
  }
}
