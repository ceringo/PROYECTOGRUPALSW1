import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloServicio/Area.dart';
import 'package:working/src/models/ModuloServicio/Servicio.dart';
import 'package:working/src/pages/Trabajo/servicios_page.dart';
import 'package:working/src/pages/home_page.dart';
import 'package:working/src/providers/request.dart' as req;
import 'package:working/global.dart' as global;

class ServiciosCreate extends StatefulWidget {
  @override
  _ServiciosCreateState createState() => _ServiciosCreateState();
}

class _ServiciosCreateState extends State<ServiciosCreate> {
  List<Area> listaArea = new List();
  List<DropdownMenuItem<String>> listaDrop = [];
  List<DropdownMenuItem<String>> listaEsp = [];
  String area = "Seleccionar Area";
  String especialidad = "Seleccionar Especialidad";
  String descripcion;
  String costo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarAreas();
  }

  _cargarAreas() async {
    List<Area> area = await req.Peticion().areas();
    setState(() {
      listaArea.addAll(area);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.deepPurpleAccent[100],
        padding: EdgeInsets.only(top: 40.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Crear",
                style: TextStyle(fontSize: 50.0),
              ),
              Divider(height: 50.0),
              _crearArea(),
              Divider(height: 10.0),
              _crearEspecialidad(),
              Divider(height: 10.0),
              _crearPrecio(),
              Divider(height: 10.0),
              _crearDescripcion(),
              Divider(height: 50.0),
              _botones(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearDescripcion() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            maxLines: 8,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.library_books,
                  color: Colors.deepPurple,
                ),
                hintText: "Soy un Buen Progrmador",
                border: OutlineInputBorder(),
                labelText: 'Descripcion'),
            onChanged: (string) {
              setState(() {
                descripcion = string;
              });
            },
          ),
        );
      },
    );
  }

  Widget _crearPrecio() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.attach_money,
                  color: Colors.deepPurple,
                ),
                hintText: '100.00',
                labelText: 'Precio Estandar',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (string) {
              setState(() {
                costo = string;
              });
            },
          ),
        );
      },
    );
  }

  Widget _crearEspecialidad() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 24.0),
              child: Icon(
                Icons.work,
                color: Colors.deepPurple,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              child: DropdownButton(
                items: listaEsp,
                hint: Text('$especialidad'),
                onChanged: (value) {
                  setState(() {
                    especialidad = value;
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<String>> getEspecialidades(String nombre) {
    List<DropdownMenuItem<String>> lista = [];
    var nombreArea = "";

    for (var area in listaArea) {
      nombreArea = area.nombre;
      var id = area.id;
      if (nombre == nombreArea) {
        for (var especialidad in area.listaEspecialidad) {
          var especialidadNombre = especialidad.nombre;
          var especialidadId = especialidad.id;
          print(especialidadNombre);
          lista.add(
            DropdownMenuItem(
              child: Text('$especialidadNombre'),
              value: '$especialidadNombre',
            ),
          );
        }
      }
    }
    return lista;
  }

  Widget _crearArea() {
    if (listaDrop.isEmpty) {
      for (var area in listaArea) {
        var nombre = area.nombre;
        var id = area.id;
        listaDrop.add(
          DropdownMenuItem(
            child: Text('$nombre'),
            value: '$nombre',
          ),
        );
      }
    }
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 24.0),
              child: Icon(
                Icons.spellcheck,
                color: Colors.deepPurple,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              child: DropdownButton(
                items: listaDrop,
                hint: Text('$area'),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    area = value;
                    listaEsp = getEspecialidades(value);
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }

  _registrar() async {
    List<Servicio> resp = await req.Peticion().servicio(
        descripcion, especialidad, global.PERSONA.id.toString(), costo);
    setState(() {
      global.SERVICIO.addAll(resp);
    });
  }

  Widget _botones() {
    return Container(
      padding: EdgeInsets.only(top: 60.0),
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
            onPressed: () {
              _registrar();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ServicioPage()));
            },
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.redAccent,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
