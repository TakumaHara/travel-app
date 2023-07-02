import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/screens/map_screen.dart';
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
          //authStateChanges() メソッドによって、FirebaseAuth インスタンスのログイン状態の変更を監視 (subscribe) することができ、
          // それを Stream 型でリアルタイムに受け取ることができます。
          child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                // User が null ではない場合、Map画面へ
                if (snapshot.hasData) {
                  Navigator.pushNamed(context, MapScreen.id);
                }
                // User が nullの場合、Login/Register画面へ
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: ()=>
                        Navigator.pushNamed(context, LoginScreen.id), child: const Text("Login")),
                    TextButton(onPressed: ()=>
                        Navigator.pushNamed(context, RegisterScreen.id), child: const Text("Register")),
                  ],
                );
              }
          ),
        )
    );
  }
}
