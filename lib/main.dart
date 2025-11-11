import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:literary_heaven/firebase_options.dart';
import 'package:literary_heaven/models/user.dart';
import 'package:literary_heaven/screens/login.dart';
import 'package:literary_heaven/screens/register.dart';
import 'package:literary_heaven/screens/contact.dart';
import 'package:literary_heaven/screens/home_screen.dart';
import 'package:literary_heaven/screens/privacy_policy_screen.dart';
import 'package:literary_heaven/screens/my_books_screen.dart';
import 'package:literary_heaven/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
        routes: {
          '/register': (context) => const MyRegister(),
          '/login': (context) => const MyLogin(),
          '/contact': (context) => const ContactPage(),
          '/home': (context) => const HomeScreen(),
          '/my-books': (context) => const MyBooksScreen(),
          '/privacy-policy': (context) => const PrivacyPolicyScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return const MyLogin();
    } else {
      return const HomeScreen();
    }
  }
}
