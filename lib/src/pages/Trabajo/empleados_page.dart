////// ESTA CLASE NO SE ESTA USANDO PORQUE AHORA SE VISUALIZA EN EL MAPA Y NO ASI EN UNA LISTA

import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloEmpleado/EmpleadoIA.dart';
import 'package:working/src/pages/Trabajo/contratar_page.dart';
import 'package:working/src/providers/request.dart' as req;

class ListaEmpleadosPage extends StatefulWidget {
  final String id;
  final String titulo;
  ListaEmpleadosPage({Key key, this.id, this.titulo}) : super(key: key);
  @override
  _ListaEmpleadosPageState createState() => _ListaEmpleadosPageState();
}

class _ListaEmpleadosPageState extends State<ListaEmpleadosPage> {
  List<EmpleadosIA> _listaEmpleados = new List();
  _cargarAreas() async {
    List<EmpleadosIA> lista = await req.Peticion().empleados(widget.id);
    setState(() {
      _listaEmpleados.addAll(lista);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text(widget.titulo),
          centerTitle: true,
          leading: IconButton(
          tooltip: 'Previous choice',
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.of(context).pop();
    },
        )),
        body: Container(
          child: ListView.builder(
            itemCount: _listaEmpleados.length,
            itemBuilder: (context, index) {
              EmpleadosIA empleados = _listaEmpleados[index];
              return Card(
                child: ListTile(
                  leading: Container(
                    height: 70.0,
                    width: 50.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(empleados.foto),
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        empleados.nombre + ' ' + empleados.apellidos,
                        style: TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Text(
                        empleados.nombre + ' ' + empleados.apellidos,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(empleados.precioEstandar + ' ' + '\$'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.touch_app,
                      size: 50.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContratarPage(
                                    empleado: _listaEmpleados[index],
                                  )));
                    },
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ));
  }
}
