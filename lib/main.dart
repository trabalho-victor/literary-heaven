import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// suas telas
import 'package:literary_heaven/screens/login.dart';
import 'package:literary_heaven/screens/register.dart';
import 'package:literary_heaven/screens/contact.dart';
import 'package:literary_heaven/screens/home_screen.dart';
import 'package:literary_heaven/screens/my_books_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase ANTES de rodar o app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      },
    ),
  );
}
