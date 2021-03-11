////// ESTA CLASE NO SE ESTA USANDO PORQUE AHORA SE VISUALIZA EN EL MAPA Y NO ASI EN UNA LISTA


import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloEmpleado/EmpleadoIA.dart';
import 'package:working/src/pages/Trabajo/contratar_page.dart';
import 'package:working/src/providers/request.dart' as req;
import 'package:working/global.dart' as global;
class ListaEmpleadosIAPage extends StatefulWidget {
  final String objeto;
  ListaEmpleadosIAPage({Key key, this.objeto}) : super(key: key);
  @override
  _ListaEmpleadosIAPageState createState() => _ListaEmpleadosIAPageState();
}

class _ListaEmpleadosIAPageState extends State<ListaEmpleadosIAPage> {
  List<EmpleadosIA> _listaEmpleados = new List();
  List items = getDummyList();
  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }

  _cargarListaEmpleador() async {
    List<EmpleadosIA> lista =
        await req.Peticion().contratoRapido(widget.objeto, global.PERSONA.id.toString());
    setState(() {
      _listaEmpleados.addAll(lista);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarListaEmpleador();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Empleados"),
          centerTitle: true,
        ),
        body: Container(
          child: ListView.builder(
            itemCount: _listaEmpleados.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_listaEmpleados[index].foto),
                  ),
                  title: Text(
                    _listaEmpleados[index].especialidad,
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(children: <Widget>[
                    Text(
                      _listaEmpleados[index].nombre +
                          ' ' +
                          _listaEmpleados[index].apellidos,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(_listaEmpleados[index].precioEstandar + ' ' + "Dolar"),
                  ]),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.touch_app,
                      size: 50.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContratarPage(empleado: _listaEmpleados[index])));
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
