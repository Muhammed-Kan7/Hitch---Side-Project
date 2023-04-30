import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firebase {
  static var db = FirebaseFirestore.instance;

  static void registerToFireStore(String uid) {
    db.collection("Users").doc(uid).set({"uid": uid}).onError((e, _) => print(
        "An error occurred during writing document. Please try again: $e"));
  }

  static void updatePfpToFirestore(String uid, String imageUrl) {
    db.collection("Users").doc(uid).update({"pfp": imageUrl}).onError((e, _) =>
        print(
            "An error occurred during writing document. Please try again: $e"));
  }

  static void updatePfpToAuth(User user, String imageUrl) {
    user.updatePhotoURL(imageUrl);
    print("?");
  }

  static void registerOtherDataIntoAuth(User? user) {
    if (user != null) {
      user.updateDisplayName("Muhammed");
      user.updatePhotoURL("");
    }
  }
}
