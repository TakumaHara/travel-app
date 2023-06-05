import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/screens/register_screen.dart';
import 'package:travelapp/screens/welcome_screen.dart';

import 'login_screen.dart';
import 'map_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        MapScreen.id:(context)=>MapScreen()
      },
    );
  }
}

