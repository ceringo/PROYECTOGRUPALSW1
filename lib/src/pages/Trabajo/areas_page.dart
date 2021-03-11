import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloServicio/Area.dart';

import 'package:working/src/pages/Trabajo/especialidades_page.dart';
import 'package:working/src/providers/request.dart' as req;

class AreasPage extends StatefulWidget {
  @override
  _AreasPageState createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> {
  List<Area> listaArea = new List();
  _cargarAreas() async {
    List<Area> lista = await req.Peticion().areasServicios();
    setState(() {
      listaArea.addAll(lista);
    });
  }

  @override
  void initState() {
    super.initState();
    _cargarAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Areas"),
          centerTitle: true,
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: _listaAreas(),
    );
  }

  Widget _listaAreas() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: ListView.builder(
        itemCount: listaArea.length,
        itemBuilder: (context, index) {
          return Container(
            height: 90,
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(
                  Icons.call_made,
                  color: Colors.white,
                  size: 50.0,
                ),
                title: Container(
                  padding: EdgeInsets.only(left: 80.0),
                  child: Text(
                    listaArea[index].nombre,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EspecialidadesPage(
                                lista: listaArea[index].listaEspecialidad,
                              )));
                },
              ),
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
