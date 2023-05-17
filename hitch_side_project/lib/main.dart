import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hitch_side_project/Components/loginPage.dart';

import 'Firebase/Firebase_options.dart';

// void main() {
//   runApp(MyApp());
// }

void main() async {
  //setup  async await db init
  WidgetsFlutterBinding.ensureInitialized(); // ???
  await Firebase.initializeApp(
    name:"first",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      )),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

 