import 'package:flutter/material.dart';
import 'package:working/src/models/ModuloEmpleado/EmpleadoIA.dart';
import 'package:working/src/providers/request.dart' as req;
import 'package:working/global.dart' as global;
//get location
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class ContratarPage extends StatefulWidget {
  final EmpleadosIA empleado;
  ContratarPage({Key key, this.empleado}) : super(key: key);
  @override
  _ContratarPageState createState() => _ContratarPageState();
}

class _ContratarPageState extends State<ContratarPage> {
  EmpleadosIA empleados = new EmpleadosIA();
  //to get my location by will

  LocationData _startLocation;
  Location _locationService = new Location();
  PermissionStatus _permission;
  String error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      empleados = widget.empleado;
    });
    //calling the function of current location
    initPlatformState();
  }

  //get location funcion
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
          title: Text("Informacion de Persona"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _fotoUsuario(),
              _calificacionUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _nombreUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _apellidoUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _telefonoUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _precioUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _correoUsuario(),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              _epecialidadUsuario(),
              Padding(padding: const EdgeInsets.only(top: 30.0)),
              _botones(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _epecialidadUsuario() {
    return Text(empleados.especialidad,
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold));
  }

  Widget _calificacionUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Calificacion : ",
          style: TextStyle(fontSize: 24.0),
        ),
        //  _crearEstrella(empleados.calificacionEmpleado),
      ],
    );
  }

  _crearEstrella(int longitud) {
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

  Widget _telefonoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Telefono : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.telefono)
      ],
    );
  }

  Widget _correoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Correo : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.correo)
      ],
    );
  }

  Widget _precioUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Precio : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.precioEstandar + ' ' + 'Bs')
      ],
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
              print("latitud" + _startLocation.latitude.toString());
              print("longitud" + _startLocation.longitude.toString());
              req.Peticion().realizarSolicitudContrato(
                  _startLocation.latitude.toString(),
                  _startLocation.longitude.toString(),
                  global.PERSONA.id.toString(),
                  empleados.idServicio.toString());
              Navigator.pushReplacementNamed(context, 'home');
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

  Widget _botones() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        "CONTRATAR",
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blueAccent,
      onPressed: () {
        alerta("Esta seguro de Soicitar El contrato? ");
      },
    );
  }

  Widget _apellidoUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Apellido : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.apellidos)
      ],
    );
  }

  Widget _nombreUsuario() {
    return Row(
      children: <Widget>[
        Text(
          "       Nombre : ",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(empleados.nombre)
      ],
    );
  }

  Widget _fotoUsuario() {
    return Column(
      children: <Widget>[
        // Padding(padding: const EdgeInsets.only(top: 10.0)),
        Center(
          child: Image.network(
            empleados.foto.toString(),
            height: 250.0,
            width: 250.0,
          ),
        ),
      ],
    );
  }
}
