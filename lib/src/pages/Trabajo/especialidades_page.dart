import 'package:flutter/material.dart';
//get location
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'package:working/src/models/ModuloServicio/Area.dart';
import 'package:working/src/pages/Trabajo/mapa_empleado_page.dart';

class EspecialidadesPage extends StatefulWidget {
  final List<ListaEspecialidad> lista;
  EspecialidadesPage({Key key, this.lista}) : super(key: key);
  @override
  _EspecialidadesPageState createState() => _EspecialidadesPageState();
}

class _EspecialidadesPageState extends State<EspecialidadesPage> {
  List<ListaEspecialidad> espcialidad = new List();
  //to get my location by will

  LocationData _startLocation;
  Location _locationService = new Location();
  PermissionStatus _permission;
  String error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    espcialidad = widget.lista;
    print('nombre' + espcialidad[0].nombre);
    //calling the function of current location
    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission == PermissionStatus.GRANTED) {
          location = await _locationService.getLocation();
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Especialidades"),
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
        itemCount: espcialidad.length,
        itemBuilder: (context, index) {
          return Container(
            height: 90.0,
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(
                  Icons.call_made,
                  color: Colors.white,
                  size: 50.0,
                ),
                title: Container(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Text(
                    espcialidad[index].nombre,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                ),
                onTap: () {
                  //Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmpleadosMapa(
                                latitude: _startLocation.latitude,
                                longitude: _startLocation.longitude,
                                id: espcialidad[index].id.toString(),
                                titulo: espcialidad[index].nombre,
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
