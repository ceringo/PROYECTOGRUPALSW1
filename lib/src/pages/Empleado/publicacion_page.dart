import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:working/src/pages/Empleado/publicacion_create_page.dart';

class PublicacionPage extends StatefulWidget {
  @override
  _PublicacionPageState createState() => _PublicacionPageState();
}

class _PublicacionPageState extends State<PublicacionPage> {
  List items = getDummyList();
  static List getDummyList() {
    List list = List.generate(2, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publicacion"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PublicacionCreate(
                        accion: 'Crear',
                      )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: RefreshIndicator(
        child: _card(),
        onRefresh: _refresh,
      ),
    );
  }

  Future<Null> _refresh() async {
    Future.delayed(Duration(seconds: 10));
    setState(() {
      print("hola que hace bro");
    });
    return null;
  }

  Widget _card() {
    return Wrap(
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 100.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://is2-ssl.mzstatic.com/image/thumb/Video2/v4/e1/69/8b/e1698bc0-c23d-2424-40b7-527864c94a8e/pr_source.lsr/268x0w.png"))),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                items[index],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                child: Container(
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.teal),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "3D",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "His genius finally recognized by his idol Chester",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  color: Colors.redAccent,
                  icon: Icons.clear,
                  onTap: () {
                    debugPrint("eliminarPublicacion");
                  },
                ),
                IconSlideAction(
                  color: Colors.greenAccent,
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PublicacionCreate(
                                  accion: 'Editar',
                                )));
                  },
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
