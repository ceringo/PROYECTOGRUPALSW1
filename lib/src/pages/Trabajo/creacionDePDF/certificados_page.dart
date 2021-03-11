import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:edge_detection/edge_detection.dart';
import 'package:toast/toast.dart';

import 'package:working/src/providers/request.dart' as req;

class ImageScreen extends StatefulWidget {
  final String titulo;
  ImageScreen({Key key, this.titulo}) : super(key: key);
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String pathPdf;
  List<File> photos_list = new List();
  List<String> url_image = new List();

  String imagePath = "";
  String fecha = "";

  alerta(String value) {
    // aqui guardare las imagenes que se encuentran en la lista y obtendre sus url
    AlertDialog dialog = new AlertDialog(
      content: Text(value,
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).primaryColor,
          )),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              _crearPdf(widget
                  .titulo); // nombre con el que se guardara el documento pdf
              Navigator.of(context).pop();
              Navigator.of(context).pop();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de " + widget.titulo),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              photos_list.isNotEmpty
                  ? alerta("¿ esta seguro de guardar los datos ?")
                  : Toast.show("No se realizo ningun cambio", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            },
          )
        ],
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/fondo_azul_oscuro.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: photos_list.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Image.file(
                    photos_list[index],
                    height: 500.0,
                    width: 400.0,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _edge();
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _edge() async {
    /* var cade = await EdgeDetection.detectEdge;
    File _image = new File(cade);
    setState(() {
      photos_list.add(_image);
    });*/
  }

  _crearPdf(String nombre) async {
    await req.Peticion().crearPDF(photos_list, nombre);
  }
}
