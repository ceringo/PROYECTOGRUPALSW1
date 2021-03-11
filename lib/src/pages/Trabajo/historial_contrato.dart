import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloTrabajo/MisContratos.dart';
import 'package:working/src/pages/Trabajo/info_contrato.dart';
import 'package:working/src/providers/request.dart' as req;

class MisContratosEnEspera extends StatefulWidget {
  final String id;
  final String accion;
  MisContratosEnEspera({Key key, this.id, this.accion}) : super(key: key);
  @override
  _MisContratosEnEsperaState createState() => _MisContratosEnEsperaState();
}

class _MisContratosEnEsperaState extends State<MisContratosEnEspera> {
  List<MisContratos> _listaContratos = [];

  _cargarContratos() async {
    List<MisContratos> lista = await req.Peticion()
        .misContratosEnEspera(widget.accion, widget.id.toString());
    setState(() {
      _listaContratos.addAll(lista);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarContratos();
  }

  Future<Null> _refresh() async {
    Future.delayed(Duration(seconds: 10));
    setState(() {
      _listaContratos.clear();
      _cargarContratos();
    });
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Contratos En " + widget.accion),
          centerTitle: true,
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: _listaContratos.length,
          itemBuilder: (context, index) {
            MisContratos data = _listaContratos[index];
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
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Column(children: <Widget>[
                  Text(
                    data.nombre + ' ' + data.apellidos,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Fecha : " + data.fecha.toString().substring(0, 11),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                            builder: (context) => InfoContrato(
                                  empleados: _listaContratos[index],
                                  accion: widget.accion,
                                )));
                  },
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
