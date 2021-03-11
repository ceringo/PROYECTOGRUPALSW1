import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

//get location
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'package:working/src/blocs/provider.dart';
import 'package:working/src/pages/manual.dart';
import 'package:working/src/pages/menuEmpleado.dart';
import 'package:working/global.dart' as global;
import 'package:working/src/providers/request.dart' as req;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//to get my location by will

  LocationData _startLocation;
  Location _locationService = new Location();
  PermissionStatus _permission;
  String error;

  LoginBloc bloc = new LoginBloc();
  Widget notifications() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.notifications),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "nada",
          child: Text("one"),
        ),
      ],
    );
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
      actualizar(location);
    });
  }

  actualizar(location) async {
    await req.Peticion().guardarUbicacion(global.PERSONA.id.toString(),
        location.latitude.toString(), location.longitude.toString());
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('CHAMBITA'),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 20.0),
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManualPage()));
              },
            ),
            IconButton(
              padding: EdgeInsets.only(right: 20.0),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 17.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Hola" + ' ' + global.PERSONA.nombre,
                    style: TextStyle(fontSize: 48.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                Text(
                  "Bienvenido A",
                  style: TextStyle(fontSize: 40.0),
                ),
                Text(
                  "Chambita",
                  style: TextStyle(fontSize: 80.0),
                ),
                Padding(padding: EdgeInsets.only(top: 50.0)),
                Container(
                  height: 200,
                  child: Image.network(
                      'http://${global.API_URL}/img/landing/logo.png'),
                ),
              ],
            ),
          ),
        ),
        drawer: MenuLateralEmpleado());
  }

  Widget _gif() {
    return Image(
      image: AssetImage('assets/tenor.gif'),
      height: 300.0,
      width: 300.0,
      fit: BoxFit.cover,
    );
  }
}
