import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:form_validator/src/bloc/validators.dart';

class LoginBloc with Validator {

  final _emailController   = BehaviorSubject<String>();
  final _passwordControlle = BehaviorSubject<String>();

  // Recuperar datos stream
  Stream<String> get emailStream          => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream       => _passwordControlle.stream.transform(validarPassword);

  Stream<bool>   get formValidationStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // insertar valores al stream (Se pasa como referencia - NO SE AJECUTA)
  Function(String) get changueEmail => _emailController.sink.add;
  Function(String) get changuePassword => _passwordControlle.sink.add;

  // Obtener el ultimo valor ingresado a los streams
  String get email    => _emailController.value;
  String get password => _passwordControlle.value;


  dispose() {
    _emailController?.close();
    _passwordControlle?.close();
  }

}