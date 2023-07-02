import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'map_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              await auth.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text
              );
              await  Navigator.pushNamed(context, MapScreen.id);
            }on FirebaseAuthException catch (e) {
              if (e.code == 'email-already-in-use') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('指定したメールアドレスは登録済みです'),
                  ),
                );
                print('指定したメールアドレスは登録済みです');
              } else if (e.code == 'invalid-email') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('メールアドレスのフォーマットが正しくありません'),
                  ),
                );
                print('メールアドレスのフォーマットが正しくありません');
              } else if (e.code == 'operation-not-allowed') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('指定したメールアドレス・パスワードは現在使用できません'),
                  ),
                );
                print('指定したメールアドレス・パスワードは現在使用できません');
              } else if (e.code == 'weak-password') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('パスワードは６文字以上にしてください'),
                  ),
                );
                print('パスワードは６文字以上にしてください');
              }
            }
          }, child: Text("Register")),
          infoText!=null?Text(infoText!):SizedBox()
        ],
      ),
    );
  }
}
