import 'package:firebase06092121/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_options.dart';

// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, non_constant_identifier_names

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.sunflowerTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const Login()
        // initialRoute: '/welcome_screen',
        // routes: {
        //   '/welcome_scrren':(context) => const Welcome_screen(),
        //   '/customer_home' : (context) => const CustomerHomeScreen(),

        // },
        );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email;
  late String password;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //firebase
  final auth = FirebaseAuth.instance;

  late GoogleSignInAccount userObj;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Signed In"),
            duration: Duration(milliseconds: 1000),
          ),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed with code: ${e.code}"),
          duration: const Duration(milliseconds: 1000),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                  hintText: 'email',
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an Email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
                },
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                    hintText: 'password',
                  ),
                  controller: passController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => value!.length < 6 ? 'Please is too short' : null),
              TextButton(
                child: Text('Login'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    email = emailController.text;
                    password = passController.text;
                    login();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  _signInWithGoogle();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Text('Google Sign In'),
              )
            ],
          ),
        ),
      ),
    );
  }

  _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
