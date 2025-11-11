import 'package:flutter/material.dart';
import 'package:literary_heaven/screens/login.dart';
import 'package:literary_heaven/screens/register.dart';
import 'package:literary_heaven/screens/contact.dart';
import 'package:literary_heaven/screens/home_screen.dart';
import 'package:literary_heaven/screens/privacy_policy_screen.dart';

import 'package:literary_heaven/screens/my_books_screen.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLogin(),
      routes: {
        '/register': (context) => MyRegister(),
        '/login': (context) => MyLogin(),
        '/contact': (context) => ContactPage(),
        '/home': (context) => HomeScreen(),
        '/my-books': (context) => const MyBooksScreen(),
        '/privacy-policy': (context) => const PrivacyPolicyScreen(),
      },
    ),
  );
}
