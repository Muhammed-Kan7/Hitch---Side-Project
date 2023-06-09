import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hitch_side_project/Components/HomePage.dart';
import 'package:hitch_side_project/Components/SignUp.dart';
import 'package:hitch_side_project/Firebase/firebase.functions.dart';
import 'package:twitter_login/entity/auth_result.dart';
import '../Firebase/Firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_login/twitter_login.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String userEmail = "";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future logininWithTwitter() async {
    final twitterLogin = new TwitterLogin(
        apiKey: 'hYFv1b7a6tRBSp7hgwt92vEeM',
        apiSecretKey: '5ohn9WWHVDKvqPMwXtCYKc9AfwOJltBqiPovVHLklUX2rppgYA',
        redirectURI:
            'https://hitch---sideproject.firebaseapp.com/__/auth/handler');
    print("TEST TWITTER!!!!!!!!!");
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        print('Logged in');
        print(authResult.authToken);
        print(authResult.authTokenSecret);
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('Login cancel');
        break;
      case TwitterLoginStatus.error:
      case null:
        print('Login error');
        break;
      default:
        print("other ERROR");
    }
  }

  Future<void> _handleSignIn() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // User successfully signed in
    } on FirebaseAuthException catch (e) {
      // Show error message
    }
  }

  // void test() {
  //   print("HELLO WORLD!!!");
  //   signInWithGoogle();
  // }

  Future signinwithGoogleBTN() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    print(FirebaseAuth.instance.currentUser);
    try {
      await signInWithGoogle();
         Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    print("hello");
    } on FirebaseAuthException catch (e) {
      print("SIGN IN WITH GOOGLE ERROR !!!!!!");
      return;
    }

 
  }




  Future<UserCredential?> signInWithGoogle() async {
    // Create an instance of the firebase auth and google signin
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>["email"]);
    print("googleSignIn");
    //Triger the authentication flow

    print("testrewrewr");
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    print("test455");
    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    print("test");
    //Create a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("tesdfghyujikt");
    print(credential);
    //GoogleSignIn().signOut();

    //Sign in the user with the credentials
    //final UserCredential userCredential = await auth.signInWithCredential(credential);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: new LinearGradient(colors: [Colors.blue, Colors.blue])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: height * 0.15,
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.15),
              height: height * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: ListView(
                children: [
                  Text(
                    'Login'.toUpperCase(),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: width * 0.8,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextField(
                        controller: emailController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Email * ",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.blue),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextField(
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password * ",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.blue),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                      decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [Colors.blue, Colors.blue]),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.blue,
                                offset: Offset(2, 2))
                          ]),
                      child: Text(
                        "Login".toUpperCase(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: ImageIcon(
                      AssetImage("assets/google.png"),
                      size: 24,
                    ),
                    label: const Text("sign in"),
                    onPressed: signinwithGoogleBTN,
                  ),
                  InkWell(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: logininWithTwitter,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.lock), // <-- Use 'Image.asset(...)' here
                            SizedBox(width: 12),
                            Text('Sign in with Twitter'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: width * 0.8,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    "Don't Have Account ?".toUpperCase(),
                    style: TextStyle(fontSize: 16, letterSpacing: 1.7),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [Colors.blue, Colors.blue]),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.blue,
                                  offset: Offset(2, 2))
                            ]),
                        child: Text(
                          "Sign Up".toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.7),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton.icon(
                      icon: const Icon(Icons.lock_open),
                      label: const Text('sign in'),
                      onPressed: () => {
                            print(GoogleSignIn().signOut())
                            // GoogleSignIn().signOut();
                          })
                ])
          ],
        ),
      ),
    );
  }
}
