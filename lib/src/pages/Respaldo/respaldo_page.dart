import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:edge_detection/edge_detection.dart';
import 'package:working/src/models/ModuloServicio/Servicio.dart';
import 'package:working/src/pages/Trabajo/creacionDePDF/certificados_page.dart';
import 'package:working/src/providers/request.dart' as req;

class SolicitarRespaldoPage extends StatefulWidget {
  final Servicio work;
  SolicitarRespaldoPage({
    Key key,
    this.work,
  }) : super(key: key);
  @override
  _SolicitarRespaldoPageState createState() => _SolicitarRespaldoPageState();
}

class _SolicitarRespaldoPageState extends State<SolicitarRespaldoPage> {
  /// para el scanneo de documentos
  List<File> antecedentes_list = new List();
  List<File> certificados_list = new List();
  File _imageCI;
  File _imagePerson;

  String fotoPerson;

  /// esto se tiene q mandar por la api.... es la url de la imagen
  String fotoCI;

  ///esto se tiene que mandar por la api

//curriculum
  String _fileName;
  String _path = "";
  String imagen = "";

  /// esto es la url de curriculum se tiene que mandar x la api
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
//antecedentes
  String _fileName1;
  String _path1 = "";
  String imagen1 = "";

  /// esto es la url de curriculum se tiene que mandar x la api
  Map<String, String> _paths1;
  String _extension1;
  bool _loadingPath1 = false;

//certificados
  String _fileName2;
  String _path2 = "";
  String imagen2 = "";

  /// esto es la url de curriculum se tiene que mandar x la api
  Map<String, String> _paths2;
  String _extension2;
  bool _loadingPath2 = false;

  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  _guardarImage() async {
    String url = await req.Peticion().subirImagen(File(_path));
    setState(() {
      imagen = url;
    });
  }

  _guardarImage1() async {
    String url = await req.Peticion().subirImagen(File(_path1));
    setState(() {
      imagen1 = url;
    });
  }

  _guardarImage2() async {
    String url = await req.Peticion().subirImagen(File(_path2));
    setState(() {
      imagen2 = url;
    });
  }

  Future _getImagePerson() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imagePerson = image;
    });
    _guardarImagePerson();
  }

  Future _getImageCI() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageCI = image;
    });
    _guardarImageCI();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
    _controller1.addListener(() => _extension1 = _controller1.text);
    _controller2.addListener(() => _extension2 = _controller2.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _paths = null;
      _path = await FilePicker.getFilePath(
        type: _pickingType,
        // fileExtension: _extension,
      );
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null
              ? _paths.keys.toString()
              : '...';
    });
    _guardarImage();
  }

  void _openFileExplorer1() async {
    setState(() => _loadingPath1 = true);
    try {
      _paths1 = null;
      _path1 = await FilePicker.getFilePath(
        type: _pickingType,
        // fileExtension: _extension1,
      );
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath1 = false;
      _fileName1 = _path1 != null
          ? _path1.split('/').last
          : _paths1 != null
              ? _paths1.keys.toString()
              : '...';
    });
    _guardarImage1();
  }

  void _openFileExplorer2() async {
    setState(() => _loadingPath2 = true);
    try {
      _paths2 = null;
      _path2 = await FilePicker.getFilePath(
        type: _pickingType,
        // fileExtension: _extension2,
      );
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath2 = false;
      _fileName2 = _path2 != null
          ? _path2.split('/').last
          : _paths2 != null
              ? _paths2.keys.toString()
              : '...';
    });
    _guardarImage2();
  }

  _guardarImageCI() async {
    String url = await req.Peticion().subirImagen(_imageCI);
    setState(() {
      fotoCI = url;
    });
  }

  _guardarImagePerson() async {
    String url = await req.Peticion().subirImagen(_imagePerson);
    setState(() {
      fotoPerson = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Seleccionar Respaldo'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 40.0)),
                _fotoPerson(),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                _fotoCI(),
                Divider(height: 80.0),
                Text(_path),
                RaisedButton(
                  onPressed: () => _openFileExplorer(),
                  child: Text("Seleccionar Curriculum"),
                ),
                Divider(height: 20.0),
                Text(_path1),
                RaisedButton(
                  onPressed: () => alertaAntecedente("PDF"),
                  child: Text("Adjuntar Antecedentes"),
                ),
                Divider(height: 20.0),
                Text(_path2),
                RaisedButton(
                  onPressed: () => alertaCertificado("PDF"),
                  child: Text("Adjuntar Certificados"),
                ),
                Divider(height: 70.0),
                _botones()
              ],
            ),
          )),
    );
  }

  alertaAntecedente(String value) {
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
              _openFileExplorer1();
              Navigator.of(context).pop();
            },
            child: Text("obtenerPDf")),
        FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageScreen(
                            titulo: "Antecedente",
                          )));
            },
            child: Text("CrearPdf")),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }

  alertaCertificado(String value) {
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
              _openFileExplorer2();
              Navigator.of(context).pop();
            },
            child: Text("obtenerPDf")),
        FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageScreen(
                            titulo: "Certificados",
                          )));
            },
            child: Text("CrearPdf")),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }

  Widget _fotoCI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 100.0,
          width: 100.0,
          child:
              _imageCI == null ? Text('No hay Imagen') : Image.file(_imageCI),
        ),
        FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          mini: true,
          onPressed: () => _getImageCI(),
          child: Icon(
            Icons.camera,
          ),
        ),
      ],
    );
  }

  Widget _fotoPerson() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 100.0,
          width: 100.0,
          child: _imagePerson == null
              ? Text('No hay Imagen')
              : Image.file(_imagePerson),
        ),
        FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          mini: true,
          onPressed: () => _getImagePerson(),
          child: Icon(
            Icons.camera,
          ),
        ),
      ],
    );
  }

  Widget _botones() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              "Guardar",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blueAccent,
            onPressed: () {},
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.redAccent,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
