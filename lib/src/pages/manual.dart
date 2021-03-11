import 'package:flutter/material.dart';

class ManualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Instrucciones de manejo"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: _contenido(),
        ));
  }

  Widget _contenido() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Flujo de Trabajo de Contratar",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            children: <Widget>[
              Container(
                child: _gif("1.png"),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Text("  Al ingresar a la aplicacion" +
                      "\n" +
                      "  observamos distintas opciones," +
                      "\n" +
                      "  elegimos contratar"),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 30.0),
          child: Row(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Text("  Se nos despliega las opciones" +
                      "\n" +
                      "  de las areas que tenemos" +
                      "\n" +
                      "  elegimos computacion"),
                ),
              ),
              Container(
                child: _gif("2.png"),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          ////3er screen
          child: Row(
            children: <Widget>[
              Container(
                child: _gif("3.png"),
              ),
              Container(
                  child: SingleChildScrollView(
                child: Text("  Nos muestra los tipos" +
                    "\n" +
                    "  oe especialidades que tenemos," +
                    "\n" +
                    "  y elegimos el primero "),
              )),
            ],
          ),
        ),
        SingleChildScrollView(
          // 4to screen mapa
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Text("  Nos visualiza" +
                      "\n" +
                      "  El mapa, donde podremos ver" +
                      "\n" +
                      "  a los empleados activos"),
                ),
              ),
              Container(
                child: _gif("4.png"),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            children: <Widget>[
              Container(
                child: _gif("5.png"),
              ),
              Container(
                  child: SingleChildScrollView(
                child: Text("  Al elegir al empleado" +
                    "\n" +
                    "  ya podremos contratarlo," +
                    "\n" +
                    "  "),
              )),
            ],
          ),
        ),
        SingleChildScrollView(
          // 4to screen mapa
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Text("  Nos muestra una pantalla para" +
                      "\n" +
                      "  confirmar el contrato" +
                      "\n" +
                      "  al dar si," +
                      "\n" +
                      "  le mandamos nuestra ubicacion"),
                ),
              ),
              Container(
                child: _gif("6.png"),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Flujo de Trabajo Contrato Rapido",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            children: <Widget>[
              Container(
                child: _gif("1.png"),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Text("  En el menu tenemos la opcion" +
                      "\n" +
                      "  ingresamos a esa opcion," +
                      "\n" +
                      "  con el icono de la camara"),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 30.0),
          child: Row(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Text("  vemos las opciones de " +
                      "\n" +
                      "  poder tomar una fotografia" +
                      "\n" +
                      "  o sacar una de la galaria"),
                ),
              ),
              Container(
                child: _gif("7.png"),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Container(
                child: _gif("8.png"),
              ),
              Container(
                  child: SingleChildScrollView(
                child: Text("  Al Tomarnos una foto " +
                    "\n" +
                    "  nuestra IA identifica el o," +
                    "\n" +
                    "  bjeto y nosostros obtenemos al " +
                    "\n" +
                    "  de mayor probabilidad"),
              )),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 30.0),
          child: Row(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Text("  visualiamos en el mapa " +
                      "\n" +
                      "  a los empleados mas " +
                      "\n" +
                      "  cercas y que estan activos"),
                ),
              ),
              Container(
                child: _gif("9.png"),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _gif(String nombre) {
    return Image(
      image: AssetImage('assets/' + nombre),
      height: 300.0,
      width: 200.0,
      fit: BoxFit.cover,
    );
  }
}
