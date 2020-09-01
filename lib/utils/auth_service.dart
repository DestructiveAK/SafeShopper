import 'package:SafeShopper/pages/home_screen.dart';
import 'package:SafeShopper/pages/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (!snapshot.hasData) {
          return LoginPage();
        } else {
          return HomePage();
        }
      },
    );
  }

  static void signIn(String email, String password, BuildContext context,
      Function(String) errorHandler) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          errorHandler('Invalid email address');
          break;
        case 'user-not-found':
          errorHandler('User not found');
          break;
        case 'user-disabled':
          errorHandler('User account disabled.');
          break;
        case 'wrong-password':
          errorHandler('Invalid email or password');
      }
    }
  }

  static void signUp(BuildContext context, String name, String phone,
      String address, String email, String password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) => {
              AuthService.createUserDetails(
                  userCredential.user, context, name, phone, address)
            })
        .catchError((e) {
      print(e);
    });
  }

  static void createUserDetails(User user, BuildContext context, String name,
      String phone, String address) {
    FirebaseFirestore.instance.collection('/users').add({
      'userId': user.uid,
      'name': name,
      'phone': phone,
      'address': address
    }).then((user) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((e) {
      print(e);
    });
  }

  User currentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}