import 'package:flutter/material.dart';

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hitch_side_project/firebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: must_be_immutable
class MyAccountPage extends StatelessWidget {
  final _user = FirebaseAuth.instance.currentUser;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  MyAccountPage({super.key});

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    print("Success");

    image = img;
  }

  @override
  Widget build(BuildContext context) {
    Future signOut() async {
      FirebaseAuth.instance
          .setSettings(appVerificationDisabledForTesting: true);
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logging out..')),
        );
        print("Signing out with:");
        print(FirebaseAuth.instance.currentUser?.uid);
        print(FirebaseAuth.instance.currentUser?.email);

        await FirebaseAuth.instance.signOut();

        print("Currently Signed out");
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Logged in")),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(22.0),
        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const ImagePickerSF(),
                      Text(
                        (_user?.displayName ?? 'No username'),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1.5,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (_user?.email ?? 'No email'),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1.5,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (_user?.uid ?? 'No uid'),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1.5,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text("sign out"),
                        onPressed: signOut,
                      ),
                    ]))));
  
  }
}

class ImagePickerSF extends StatefulWidget{

  const ImagePickerSF({Key? key}) : super( key:key);

  @override
  _ImagePickerSF createState()=> _ImagePickerSF();
}


class _ImagePickerSF extends State<ImagePickerSF>{
  final _user = FirebaseAuth.instance.currentUser;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(
        source: ImageSource.gallery); 
       User? user = FirebaseAuth.instance.currentUser;

        if(img!=null && user!=null){
          print("picturehandeling");
          final storage = FirebaseStorage.instance;
          final storageRef = storage.ref(); 
          final uidStorageRef = storageRef.child("pfp/${user.uid}");
          final imagesRef = storageRef.child("pfp/${user.uid}/${img.name}");

          firebase.updatePfpToFirestore(user.uid,img.name);
          print(storage.app);
          print(imagesRef.fullPath);
          final gsReference =
            FirebaseStorage.instance.refFromURL("gs://hitch-923827506019.appspot.com/${imagesRef.fullPath}");

          print(gsReference);                                                                                                
          print("https://firebasestorage.googleapis.com/v0/b/hitch---sideproject.appspot.com/o/mercedes_amg_f1_w12_e_performance_4k_7-HD.jpg?alt=media&token=ef790ea3-3af2-4f85-b0e4-605c1f086a98");
   

          File file = File(img.path);

          try { 
            final listResult = await uidStorageRef.listAll();
    
            for (var item in listResult.items) {
              storage.ref(item.fullPath).delete();
            }

            await imagesRef.putFile(file); 
            firebase.updatePfpToAuth(user, await imagesRef.getDownloadURL());

          } on Exception catch (e) {
            print(e);
          }

        }else{
          print("something is null!");
        }

        print("success!!!");
        setState(() {
          image = img;  
        });
  }

  ClipRRect getProfileClipedImageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: _user?.photoURL != null
          ? Image(
              fit: true ? BoxFit.fitWidth : BoxFit.cover,
              image: NetworkImage(_user?.photoURL ?? ""),
              width: 100)
          : Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
              child: const Image(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("assets/mercedes_amg_f1_w12_e_performance_4k_7-HD.jpg"), 
                  width: 100)),
    );
  }

    ElevatedButton getImagePickButton(){
      return ElevatedButton(
                                  
            onPressed: () {
              
              getImage(ImageSource.gallery);
            },
            child: Row(
              children: const[
                Icon(Icons.image),
                Text(' From gallery'),
              ],
            ),
          );
    }


  @override
  Widget build(BuildContext context){
    if(image!=null){
      return  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
                child:Image.file(File(image?.path ?? "error"))
                ),getImagePickButton()
              ]
            );
      
    }
    else {
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              getProfileClipedImageWidget(),
              getImagePickButton()
            ]
          );
      }
    }
}
