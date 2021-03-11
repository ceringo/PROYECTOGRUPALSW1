import 'package:flutter/material.dart';
import 'package:working/src/blocs/provider.dart';
import 'package:working/src/pages/Empleado/publicacion_page.dart';
// import 'package:working/src/ia/imagen_IA.dart';
import 'package:working/src/pages/Trabajo/servicios_page.dart';
import 'package:working/src/pages/Usuario/perfil/InfoUser_page.dart';
import 'package:working/src/pages/home_page.dart';
import 'package:working/src/pages/Usuario/login/login_page.dart';
import 'package:working/src/pages/Usuario/login/recuperar_page.dart';
import 'package:working/src/pages/Usuario/login/register_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return TfliteHome();
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WORKING',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'info': (BuildContext context) => Info(),
          'register': (BuildContext context) => Registrar(),
          'recuperar': (BuildContext context) => Recuperar(),
          'servicio': (BuildContext context) => ServicioPage(),
          'publicidad': (BuildContext context) => PublicacionPage(),
          'aceptar': (BuildContext context) => PublicacionPage(),
          // 'contrato_rapido': (BuildContext context) =>TfliteHome(),
        },
        theme: ThemeData(
          primaryColor: Color(0xff00A0C0),
        ),
      ),
    );
  }
}
