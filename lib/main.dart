import 'package:flutter/material.dart';
import 'package:literary_heaven/home.dart';
import 'package:literary_heaven/login.dart';
import 'package:literary_heaven/register.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:literary_heaven/profile.dart';

void main() async {
  await Hive.initFlutter();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
      routes: {
        'register': (context) => MyRegister(),
        'login': (context) => MyLogin(),
      },
    ),
  );
}
