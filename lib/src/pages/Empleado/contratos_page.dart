import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloEmpleado/Soliciudes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContratosEmpleadoPage extends StatefulWidget {
  final Solicitudes solicitud;
  ContratosEmpleadoPage({Key key, this.solicitud}) : super(key: key);
  @override
  _ContratosEmpleadoPageState createState() => _ContratosEmpleadoPageState();
}

class _ContratosEmpleadoPageState extends State<ContratosEmpleadoPage> {
  List<Marker> allMarkers = [];

  GoogleMapController _controller;
  //para obtener mi latitus y longitus
  static LatLng latLng;
  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(double.parse(widget.solicitud.latitudEmpleador),
            double.parse(widget.solicitud.longitudEmpleador))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Solicitud'),
        centerTitle: true,
      ),
      body: Stack(children: [
        Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      double.parse(widget.solicitud.latitudEmpleador),
                      double.parse(widget.solicitud.longitudEmpleador),
                    ),
                    zoom: 12.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    //alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: _zoom_In,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 19),
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.green),
                        child: Icon(
                          Icons.zoom_in,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 19.0),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: _zoom_Out,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 19),
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.red),
                        child: Icon(Icons.zoom_out, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.solicitud.foto),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      _crearEstrella(widget.solicitud.calificacionEmpleador),
                    ],
                  ),
                  Text(
                    "servicio",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    widget.solicitud.especialidad,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Text(
                    widget.solicitud.nombre + ' ' + widget.solicitud.apellidos,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Container(
                    width: 150.0,
                    child: RaisedButton(
                      elevation: 6.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.blue,
                      child: Text(
                        "Mapa Ayuda",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  alerta(String value) {
    AlertDialog dialog = new AlertDialog(
      content: Text(value,
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).primaryColor,
          )),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              // Navigator.pushReplacementNamed(context, 'home');
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

  Widget _crearEstrella(int longitud) {
    if (longitud == 1) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      );
    } else if (longitud == 2) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      );
    } else if (longitud == 3) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      );
    } else if (longitud == 4) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star),
        ],
      );
    } else if (longitud == 5) {
      return Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      );
    }
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  _zoom_In() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(double.parse(widget.solicitud.latitudEmpleador),
              double.parse(widget.solicitud.longitudEmpleador)),
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0),
    ));
  }

  _zoom_Out() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(double.parse(widget.solicitud.latitudEmpleador),
              double.parse(widget.solicitud.longitudEmpleador)),
          zoom: 12.0),
    ));
  }
}
