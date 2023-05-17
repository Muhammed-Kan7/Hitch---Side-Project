import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunctions {
  

static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]
        // scopes: [
        //   'email',
        //   'https://www.googleapis.com/auth/contacts.readonly',
        // ],
        );

    _googleSignIn.signIn().then((value) => {print("sdfsdfs")});
    //var AuthCredential credential;
    print("sign in with google!!!!");

    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

    print("!!!");

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //google.signin();
    print(gAuth.accessToken);
    print(gAuth.idToken);

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    print("???");
    return FirebaseAuth.instance.signInWithCredential(credential);
  }
}