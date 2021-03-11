import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
//get location
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'package:working/src/pages/Trabajo/empleados_page_IA.dart';
import 'package:working/src/pages/Trabajo/mapa_empleado_page%20_IA.dart';

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

class TfliteHome extends StatefulWidget {
  @override
  _TfliteHomeState createState() => _TfliteHomeState();
}

class _TfliteHomeState extends State<TfliteHome> {
  //to get my location by will
  LocationData _startLocation;
  Location _locationService = new Location();
  PermissionStatus _permission;
  String error;

  String _model = ssd;
  File _image;
  String nombre_del_objeto;

  double _imageWidth;
  double _imageHeight;
  bool _busy = false;

  List _recognitions;

  @override
  void initState() {
    super.initState();
    _busy = true;
    initPlatformState();
    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
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

  loadModel() async {
    Tflite.close();
    try {
      String res;
      if (_model == yolo) {
        res = await Tflite.loadModel(
          model: "assets/tflite/yolov2_tiny.tflite",
          labels: "assets/tflite/yolov2_tiny.txt",
        );
      } else {
        res = await Tflite.loadModel(
          model: "assets/tflite/ssd_mobilenet.tflite",
          labels: "assets/tflite/ssd_mobilenet.txt",
        );
      }
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  selectFromGaleryPicker() async {
    var image;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } catch (e) {
      image = null;
    }
    if (image == null) return;
    setState(() {
      nombre_del_objeto = "";
      _busy = true;
    });
    predictImage(image);
  }

  selectFromImagePicker() async {
    var image;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);

      ///gallery
    } catch (e) {
      image = null;
    }
    if (image == null) return;
    setState(() {
      nombre_del_objeto = "";
      _busy = true;
    });
    predictImage(image);
  }

  predictImage(File image) async {
    if (image == null) return;

    if (_model == yolo) {
      await yolov2Tiny(image);
    } else {
      await ssdMobileNet(image);
    }

    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));

    setState(() {
      _image = image;
      _busy = false;
    });
  }

  yolov2Tiny(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        model: "YOLO",
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0,
        numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions;
    });
  }

  ssdMobileNet(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions;
    });
  }

  List<String> objetos = new List();

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageHeight * screen.width;

    Color blue = Colors.red;

    return _recognitions.map(
      (re) {
        objetos.add("${re["detectedClass"]}");
        // nombre_del_objeto= "${re["detectedClass"]} ";
        return Positioned(
          left: re["rect"]["x"] * factorX,
          top: re["rect"]["y"] * factorY,
          width: re["rect"]["w"] * factorX,
          height: re["rect"]["h"] * factorY,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: blue,
              width: 3,
            )),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                background: Paint()..color = blue,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    nombre_del_objeto = "";
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null
          ? Center(
              child: Container(
                padding: EdgeInsets.only(top: 100.0),
                child: Text("no hay imagen seleccionada"),
              ),
            )
          : Image.file(_image),
    ));

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Busqueda por IA"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 20.0),
            icon: Icon(Icons.send),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmpleadosMapaIA(
                        objeto: objetos.first,
                        latitude: _startLocation.latitude,
                        longitude: _startLocation.longitude)),
              );
            },
          ),
        ],
      ),
      floatingActionButton: _botones(),
      body: Stack(
        children: stackChildren,
      ),
    );
  }

  Widget _botones() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(objetos.isEmpty ? "nada" : objetos.first),
          FloatingActionButton(
              child: Icon(Icons.camera),
              heroTag: Text("camera"),
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                objetos.clear();
                selectFromGaleryPicker();
              }),
          FloatingActionButton(
              child: Icon(Icons.photo),
              heroTag: Text("camera"),
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                objetos.clear();
                selectFromImagePicker();
              }),
        ],
      ),
    );
  }
}
