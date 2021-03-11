import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:working/global.dart' as global;

import 'package:working/src/blocs/login__bloc.dart';
import 'package:working/src/blocs/provider.dart';
import 'package:working/src/models/ModuloUsuario/UsuarioMovil.dart';
import 'package:working/src/pages/home_page.dart';
import 'package:working/src/providers/request.dart' as req;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UsuarioMovil persona = new UsuarioMovil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 120.0,
            ),
          ),
          Container(
            width: size.width * 0.80,
            padding: EdgeInsets.symmetric(vertical: 30.0),
            margin: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(
                  height: 20.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 10.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 10.0,
                ),
                _crearBoton(bloc),
                _crearBotonRegistro(context)
              ],
            ),
          ),
          GestureDetector(
            child: Text(
              '¿olvido la contraseña?',
              style: TextStyle(
                  color: Color(0xff002C5D),
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            onTap: () => Navigator.pushNamed(context, 'recuperar'),
          ),
        ],
      ),
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
            child: Text('Ingresar'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Color(0xff002C5D),
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    print('=============');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('=============');

    List<UsuarioMovil> resp =
        await req.Peticion().autenticando(bloc.email, bloc.password);
    if (resp.isNotEmpty) {
      setState(() {
        global.PERSONA = resp[0];
      });

      Navigator.pushReplacementNamed(context, 'home');
    } else {
      Toast.show("usuario o contraseña incorrecta", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  Widget _crearBotonRegistro(BuildContext context) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
        child: Text('Registrar'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Color(0xff002C5D),
      textColor: Colors.white,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Color(0xff002C5D),
              ),
              hintText: 'ejemplo@gmail.com',
              labelText: 'Correo Electronico',
              // counterText: snapshot.data,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Color(0xff002C5D),
              ),
              labelText: 'Contraseña',
              // counterText: snapshot.data,
              //  errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xff002C5D),
            Color(0xff002C5D),
            // Color(0xff002C5D),
          ],
        ),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
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
          padding: EdgeInsets.only(top: 70.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                child: Image.network(
                    'http://${global.API_URL}/img/landing/logo.png'),
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
