import 'package:flutter/material.dart';

class Recuperar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(63, 63, 156, 1.0),
        title: Text("Recuperar cuenta"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          Container(
            padding: EdgeInsets.only(top: 220.0),
            child: Column(
              children: <Widget>[
                _crearEmail(),
                SizedBox(
                  height: 20.0,
                ),
                _crearCodigo(),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {},
                  color: Colors.blue,
                  child: Text(
                    "Enviar",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return StreamBuilder(
      //stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'ejemplo@gmail.com',
                labelText: 'Correo Electronico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            //onChanged: //bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearCodigo() {
    return StreamBuilder(
      //stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.code,
                  color: Colors.deepPurple,
                ),
                hintText: '54465',
                labelText: 'Codigo',
                counterText: snapshot.data,
                errorText: snapshot.error),
            //onChanged: //bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container( 
      height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(63, 63, 156, 1.0),
          ],
        ),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          top: 50.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          bottom: 60.0,
          right: 60.0,
          child: circulo,
        ),
        Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 80.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'CHAMBITA',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
