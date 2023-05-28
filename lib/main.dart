import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:travelapp/login_screen.dart';
import 'package:travelapp/map_screen.dart';
import 'package:travelapp/register_screen.dart';
import 'package:travelapp/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
