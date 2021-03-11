import 'dart:async';

import 'package:flutter/material.dart';

class Validators {
  final validatorPassword = StreamTransformer<dynamic, dynamic>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.add("Mas de 6 caracteres por favor");
    }
  });

  final validatorEmail = StreamTransformer<dynamic, dynamic>.fromHandlers(
      handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.add("error de Email");
    }
  });
}
