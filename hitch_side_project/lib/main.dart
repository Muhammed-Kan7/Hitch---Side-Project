import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hitch_side_project/HitchHomePage.dart';
import 'package:hitch_side_project/firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  void main() => runApp(const MyApp());
}

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  static const String _title = 'Hitch Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

void login() async {
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "muhammed30.kan@gmail.com", password: "hej123");
    print("Logged in");
  } on FirebaseAuthException catch (e) {
    if (e.code == "User not found") {
      print("No user found with this email");
    } else if (e.code == "Wrong password") {
      print("Wrong password. Please try again");
    }
    print("Error:${e.code}");
  }
}

void registerAccount() async {
  await FirebaseAuth.instance.useAuthEmulator("localhost", 5500);

  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: "test123@grit.com", password: "hej123");
  } on FirebaseAuthException catch (e) {
    if (e.code == "Bad password") {
      print("Bad password. Please try again");
    } else if (e.code == "Email already exist") {
      print(
          "The email for this account already exists. Please try a different email");
    }
  } catch (e) {
    print(e);
  }
}

var emailController = TextEditingController(text: "muhammed30.kan@gmail.com");
var passController = TextEditingController(text: "hej123");
final _formKey = GlobalKey<FormState>();

class MyStatefulWidget extends StatefulWidget {
  void _redirectUser(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);

    final User? user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = firebaseAuth.currentUser;
      assert(user.uid == currentUser!.uid);

      print('signInWithGoogle succeeded: $user');

      return authResult;
    }

    return authResult;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Welcome back',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sign in',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {},
              ),
            ),
            ElevatedButton(
              onPressed: () {
                signInWithGoogle().then((UserCredential value) {
                  print(value);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                  );
                }).catchError((onError) {
                  print(onError);
                });
              },
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    // Navigate to create account screen
                  },
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ],
        ));
  }
}
