// ignore: file_names
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:hitch_side_project/Createpage.dart';
// ignore: file_names
import 'package:firebase_core/firebase_core.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = "Hitch Login";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: const MyStatefulWidget(),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidget();
}

class _MyStatefulWidget extends State<MyStatefulWidget> {
  Future<MyApp> _initializeFireBase() async {
    MyApp myApp = (await Firebase.initializeApp()) as MyApp;
    return myApp;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const <Widget>[
            Text(
              "Create account",
              style: TextStyle(
                  color: Colors.black,
                  //fontVariations: Align(alignment: Alignment.center),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email address",
                prefixIcon: Icon(Icons.mail, color: Colors.black),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: Icon(Icons.face, color: Colors.black),
              ),
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
          ],
        ));
  }
}
