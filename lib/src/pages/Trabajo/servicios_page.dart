import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloServicio/Servicio.dart';
import 'package:working/src/pages/Trabajo/servicios_create_page.dart';
import 'package:working/src/pages/Respaldo/respaldo_page.dart';
import 'package:working/global.dart' as global;
import 'package:working/src/providers/request.dart' as req;

class ServicioPage extends StatefulWidget {
  final List<Servicio> servicio;

  ServicioPage({Key key, this.servicio}) : super(key: key);

  @override
  _ServicioPageState createState() => _ServicioPageState();
}

class _ServicioPageState extends State<ServicioPage> {
  bool isSwitched = global.SERVICIOGENERAL;
  List<Servicio> lista = new List();

  @override
  void initState() {
    super.initState();
    _listarServicios();
  }

  _listarServicios() async {
    print(global.PERSONA.id.toString());
    List<Servicio> lis =
        await req.Peticion().listarServicio(global.PERSONA.id.toString());
    setState(() {
      lista.addAll(lis);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 140.0),
            child: Row(
              children: <Widget>[
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    String bandera = "";
                    if (value) {
                      bandera = "habilitar";
                    } else {
                      bandera = "deshabilitado";
                    }
                    _cambiarAll(global.PERSONA.id.toString(), bandera);
                    setState(() {
                      global.SERVICIOGENERAL = !global.SERVICIOGENERAL;
                    });
                  },
                  activeTrackColor: Colors.green,
                  activeColor: Colors.white,
                ),
                Text(
                  "OFF/ON",
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: lista.isEmpty ? 0 : lista.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.work)),
                title: Text(lista[index].nombre),
                subtitle: Text(lista[index].descripcion),
                trailing: Container(
                  width: 110.0,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SolicitarRespaldoPage(
                                        /*  work: lista[index]*/)));
                          }),
                      Switch(
                        value: int.parse(lista[index].estadoServicio) == 1
                            ? true
                            : false,
                        onChanged: (value) {
                          _cambiar(lista[index].id.toString());
                        },
                        activeTrackColor: Colors.green,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ServiciosCreate()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _cambiar(String id) async {
    await req.Peticion().cambiarEstado(id);
    Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ServicioPage()));
  }

  _cambiarAll(String id, String bandera) async {
    await req.Peticion().cambiarEstadoAll(id, bandera);
    Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ServicioPage()));
  }

  List items = getDummyList();
  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
}
