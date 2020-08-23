import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('Logged in'),),
          FlatButton(child: Text('Logout'), onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}