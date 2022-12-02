import 'package:auth_firebase_tp/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() {
  initfirebase();
  runApp(const MyApp());
}

Future<void> initfirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String emailadress = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign in "),
        ),
        body: Form(
          key: formKey,
          child: Column(children: [
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Your adress',
                hintText: 'person@gmail.com',
              ),
              onChanged: (value) {
                setState(() {
                  emailadress = value;
                });
              },
              validator: (value) {
                if (value == null || value == value.isEmpty) {
                  return "Field can't be empty !";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Your password',
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              validator: (value) {
                if (value == null || value == value.isEmpty) {
                  return "password can't be empty !";
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: Container()),
                Text(
                  "Forgot your Password?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                validateForm();
              },
              child: Text("Submit"),
            ),
            SizedBox(height: 30),
            Column(
              children: [
                Text(
                  "don't have an account? ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[500],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text(
                    "Sign up",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ]),
        ));
  }

//logged in
  Future<void> signin(email, password) async {
    try {
      print(emailadress);
      print(password);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion valide')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('user-not-found')),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('wrong-password')),
        );
      }
    }
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      signin(emailadress, password);
      //signup(emailadress, password);
    }
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: Column(children: [
        Text("helllo"),
        Text("helllo"),
        Text("helllo"),
      ]),
    );
  }
}
