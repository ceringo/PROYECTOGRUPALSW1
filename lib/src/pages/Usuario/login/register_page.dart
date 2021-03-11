import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:working/src/models/ModuloUsuario/UsuarioMovil.dart';

import 'package:working/src/providers/request.dart' as req;
import 'package:working/global.dart' as global;

class Registrar extends StatefulWidget {
  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  File _image;
  String nombre,
      apellido,
      email,
      contrasenia,
      sexo = "Ninguno",
      telefono,
      imagen;
  String fechaNacimiento = "Fecha ";
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _registerForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 1,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ],
        ),
      ),
    );
    return fondoMorado;
  }

  Widget _registerForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 1.0,
            ),
          ),
          Container(
            width: size.width * 0.87,
            padding: EdgeInsets.symmetric(vertical: 30.0),
            margin: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Registrarse',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "  Foto :",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.normal),
                    ),
                    Container(
                      height: 150.0,
                      width: 180.0,
                      child: Center(
                        child: _image == null
                            ? Text('No hay Imagen')
                            : Image.file(_image),
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.deepPurple,
                      mini: true,
                      onPressed: () => _getImage(),
                      child: Icon(
                        Icons.camera,
                      ),
                    ),
                  ],
                ),
                _crearName(),
                _crearLastName(),
                _crearEmail(),
                _crearPassword(),
                _crearPhone(),
                _crearSexo(),
                _crearFechaNacimiento(context),
                _crearBotones(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    _guardarImage();
  }

  _registrar() async {
    List<UsuarioMovil> resp = await req.Peticion().registrarUsuario(nombre,
        apellido, email, contrasenia, telefono, sexo, fechaNacimiento, imagen);
    setState(() {
      global.PERSONA = resp[0];
      _loading = true;
    });
  }

  alerta(String value) {
    _registrar();
    AlertDialog dialog = new AlertDialog(
      content: Text(value,
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).primaryColor,
          )),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              _loading
                  ? Navigator.pushReplacementNamed(context, 'home')
                  : CircularProgressIndicator();
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

  Widget _crearBotones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          child: RaisedButton(
            onPressed: () {
              // _guardarImage();
              alerta("¿ esta seguro de guardar los datos ?");
            },
            child: Text(
              "Confirmar",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        Container(
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  _guardarImage() async {
    String url = await req.Peticion().subirImagen(_image);
    setState(() {
      imagen = url;
    });
  }

  Widget _crearFechaNacimiento(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.date_range, color: Colors.deepPurple),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: RaisedButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  theme: DatePickerTheme(
                    containerHeight: 150.0,
                  ),
                  showTitleActions: true,
                  minTime: DateTime(1980, 1, 1),
                  maxTime: DateTime(2015, 12, 31), onConfirm: (date) {
                setState(() {
                  fechaNacimiento = '${date.year}-${date.month}-${date.day}';
                });
              }, currentTime: DateTime.now(), locale: LocaleType.es);
            },
            child: Container(
              padding: EdgeInsets.only(right: 120),
              child: Text(
                fechaNacimiento,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _crearSexo() {
    List<DropdownMenuItem<String>> listaDrop = [];
    listaDrop.add(
      DropdownMenuItem(
        child: Text("Hombre"),
        value: "Masculino",
      ),
    );
    listaDrop.add(DropdownMenuItem(
      child: Text("Mujer"),
      value: "Femenino",
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
                hint: Text("$sexo"),
                onChanged: (value) {
                  setState(() {
                    sexo = value;
                    print(sexo);
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget _crearPhone() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: Colors.deepPurple,
                ),
                hintText: '11111111',
                labelText: 'Telefono Celular',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) {
              setState(() {
                telefono = value;
              });
            },
          ),
        );
      },
    );
  }

  Widget _crearPassword() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                hintText: '',
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) {
              setState(() {
                contrasenia = value;
              });
            },
          ),
        );
      },
    );
  }

  Widget _crearEmail() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'ejemplo@gmail.com',
                labelText: 'Email',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (string) {
              setState(() {
                email = string;
              });
            },
          ),
        );
      },
    );
  }

  Widget _crearLastName() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.mode_edit,
                  color: Colors.deepPurple,
                ),
                hintText: 'Vera Montoya',
                labelText: 'Apellido',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) {
              setState(() {
                apellido = value;
              });
            },
          ),
        );
      },
    );
  }

  Widget _crearName() {
    return StreamBuilder(
      // stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.mode_edit,
                  color: Colors.deepPurple,
                ),
                hintText: 'Brayan',
                labelText: 'Nombre',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) {
              setState(() {
                nombre = value;
              });
            },
          ),
        );
      },
    );
  }
}
