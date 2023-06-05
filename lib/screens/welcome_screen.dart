import 'package:flutter/material.dart';
import 'package:travelapp/screens/register_screen.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: ()=>
              Navigator.pushNamed(context, LoginScreen.id), child: const Text("Login")),
            TextButton(onPressed: ()=>
              Navigator.pushNamed(context, RegisterScreen.id), child: const Text("Register")),
          ],
        ),
      ),
    );
  }
}
