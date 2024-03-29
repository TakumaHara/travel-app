import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'map_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? infoText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
          ),
          TextFormField(
            controller: passwordController,
          ),
          ElevatedButton(onPressed: () async {
            try{
              final FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
              await  Navigator.pushNamed(context, MapScreen.id);
            }catch(e){
              setState(() {
                infoText = "ログインに失敗しました";
              });
            }
          }, child: Text("Login")),
          infoText!=null?Text(infoText!):SizedBox()
        ],
      ),
    );
  }
}
