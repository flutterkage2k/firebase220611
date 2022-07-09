import 'package:firebase06092121/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              await signOut();
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
    );
  }
}
