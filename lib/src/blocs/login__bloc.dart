import 'dart:async';
import 'package:rxdart/rxdart.dart';
// import 'package:working/src/blocs/validators.dart';

class LoginBloc {
  final _emailController = BehaviorSubject();
  final _passwordController = BehaviorSubject();
  final _estadoController = BehaviorSubject();

  //Recuperar los datos del Stream
  Stream<dynamic> get emailStream => _emailController.stream;
  Stream<dynamic> get passwordStream => _passwordController.stream;
  Stream<dynamic> get estadoStream => _estadoController.stream;

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeEstado => _estadoController.sink.add;

  //Obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get estado => _estadoController.value;
  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _estadoController?.close();
  }
}
