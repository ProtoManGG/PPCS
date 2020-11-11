import 'package:flutter/material.dart';

class Styling {
  final kInputDecoration = const InputDecoration(
    labelText: 'Email',
    alignLabelWithHint: true,
    labelStyle: TextStyle(fontSize: 20),
    hintText: 'Enter your Email',
    // hintStyle: TextStyle(color: Colors.white),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );

  static const String kBaseUrl = "http://192.168.0.112:8000/";
}

final style = Styling();
