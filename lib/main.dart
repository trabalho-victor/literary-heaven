import 'package:flutter/material.dart';
import 'package:literary_heaven/screens/login.dart';
import 'package:literary_heaven/screens/register.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLogin(),
      routes: {
        'register': (context) => MyRegister(),
        'login': (context) => MyLogin(),
      },
    ),
  );
}
