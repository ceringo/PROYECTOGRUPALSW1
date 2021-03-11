import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:working/src/models/ModuloEmpleado/EmpleadoIA.dart';
import 'package:working/src/pages/Trabajo/contratar_page.dart';
import 'package:working/src/providers/request.dart' as req;

class EmpleadosMapa extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String id;
  final String titulo;
  EmpleadosMapa({Key key, this.latitude, this.longitude, this.id, this.titulo})
      : super(key: key);
  @override
  _EmpleadosMapaState createState() => _EmpleadosMapaState();
}

class _EmpleadosMapaState extends State<EmpleadosMapa> {
  //lista de marcadores
  List<Marker> allMarkers = [];
  List<EmpleadosIA> _listaEmpleados = [];
  _cargarAreas() async {
    List<EmpleadosIA> lista = await req.Peticion().empleados(widget.id);
    setState(() {
      _listaEmpleados.addAll(lista);
    });
  }

  cargar_markers(List<EmpleadosIA> _lista) {
    for (var i = 0; i < _lista.length; i++) {
      setState(() {
        EmpleadosIA empleado = _lista[i];
        print("latitud de las personas =>>>>>>>>>" + empleado.latitud);
        allMarkers.add(Marker(
            markerId: MarkerId('myMarker' + i.toString()),
            draggable: true,
            icon: BitmapDescriptor.fromAsset("assets/employee.png"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContratarPage(
                            empleado: _listaEmpleados[i],
                          )));
            },
            position: LatLng(double.parse(empleado.latitud),
                double.parse(empleado.longitud))));
      });
    }
  }

  @override
  void initState() {
    allMarkers.add(Marker(
      markerId: MarkerId('position'),
      draggable: true,
      onTap: () {},
      position: LatLng(widget.latitude, widget.longitude),
      icon: BitmapDescriptor.fromAsset("assets/man.png"),
    ));

    // TODO: implement initState
    super.initState();
    _cargarAreas();
  }

  GoogleMapController _controller;
  //para obtener mi latitus y longitus
  static LatLng latLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Solicitud'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.latitude, widget.longitude),
                  zoom: 12.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
          Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: _mostrar_Empleados,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 19),
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue),
                      child: Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
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
        ],
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  _mostrar_Empleados() {
    cargar_markers(_listaEmpleados);
  }

  _zoom_In() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 18.0,
          bearing: 45.0,
          tilt: 45.0),
    ));
  }

  _zoom_Out() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(widget.latitude, widget.longitude), zoom: 12.0),
    ));
  }
}
