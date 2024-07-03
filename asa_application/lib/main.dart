import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Esta importação é necessária para o DefaultFirebaseOptions
import 'signin.dart';
import 'signup.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseConfig, // Use firebaseConfig conforme definido no firebase_options.dart
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
      routes: {
        '/signin': (context) => SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/homepage': (context) => const HomePage(),
      },
    );
  }
}
