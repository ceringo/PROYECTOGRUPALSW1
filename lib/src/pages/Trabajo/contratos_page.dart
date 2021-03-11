import 'package:flutter/material.dart';
import 'package:working/src/pages/Trabajo/historial_contrato.dart';
import 'package:working/global.dart' as global;

class MisContratosPage extends StatefulWidget {
  @override
  _MisContratosPageState createState() => _MisContratosPageState();
}

class _MisContratosPageState extends State<MisContratosPage> {
  List<String> items = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items.add("Solicitudes En Espera");
    items.add("Solicitudes Aceptados");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Mis Contratos"),
          centerTitle: true,
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100.0,
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
                      items[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    switch (items[index]) {
                      case "Solicitudes Dadas De baja por Mi":
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MisContratosEnEspera(
                                      id: global.PERSONA.id.toString(),
                                      accion: "debaja")));
                        }
                        break;

                      case "Solicitudes En Espera":
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MisContratosEnEspera(
                                      id: global.PERSONA.id.toString(),
                                      accion: "enespera")));
                        }
                        break;
                      case "Solicitudes Aceptados":
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MisContratosEnEspera(
                                      id: global.PERSONA.id.toString(),
                                      accion: 'aceptado')));
                        }
                        break;
                      case "Contratos Rechazados":
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MisContratosEnEspera(
                                      id: global.PERSONA.id.toString(),
                                      accion: "rechazado")));
                        }
                        break;
                      case "Contratos Finalizados":
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MisContratosEnEspera(
                                      id: global.PERSONA.id.toString(),
                                      accion: "finalizado")));
                        }
                        break;

                      default:
                        {}
                    }
                  },
                ),
                color: Colors.blue,
              ),
            );
          },
        ),
      ),
    );
  }
}
