import 'package:firebase06092121/main_screens/customer_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, non_constant_identifier_names

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: CustomerHomeScreen(),
    );
  }
}
