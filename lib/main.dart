import 'package:flutter/material.dart';
import 'package:literary_heaven/screens/login.dart';
import 'package:literary_heaven/screens/profile.dart';
import 'package:literary_heaven/screens/register.dart';
import 'package:literary_heaven/screens/contact.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
      routes: {
        '/register': (context) => MyRegister(),
        '/login': (context) => MyLogin(),
        '/contact': (context) => ContactPage(),
      },
    ),
  );
}
