import 'package:firebase06092121/auth/auth.dart';
import 'package:firebase06092121/home_page.dart';
import 'package:firebase06092121/screens/login_page.dart';
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
        home: StreamBuilder(
          stream: authInstance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            }
            return Login();
          },
        )

        // initialRoute: '/welcome_screen',
        // routes: {
        //   '/welcome_scrren':(context) => const Welcome_screen(),
        //   '/customer_home' : (context) => const CustomerHomeScreen(),

        // },
        );
  }
}
