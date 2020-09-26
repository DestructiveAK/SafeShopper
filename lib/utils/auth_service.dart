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

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static void signUp(BuildContext context, String name, String phone,
      String address, String email, String password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) => {
              AuthService.createUserDetails(
                  userCredential.user, context, name, email, phone, address)
            })
        .catchError((e) {
      print(e);
    });
  }

  static void createUserDetails(User user, BuildContext context, String name,
      String email, String phone, String address) {
    // FirebaseFirestore.instance.collection('/users').add({
    //   'userId': user.uid,
    //   'name': name,
    //   'email': email,
    //   'phone': phone,
    //   'address': address
    // }).then((user) {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushReplacementNamed('/home');
    // }).catchError((e) {
    //   print(e);
    // });
    FirebaseFirestore.instance.collection('/users').doc(user.uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address
    }).then((user) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((e) {
      print(e);
    });
  }

  static void changePassword(String password, String newPassword) {
    AuthCredential credential = EmailAuthProvider.credential(
      email: FirebaseAuth.instance.currentUser.email,
      password: password,
    );
    FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential)
    .then((value) {
      FirebaseAuth.instance.currentUser.updatePassword(newPassword)
      .then((value) {
        FirebaseAuth.instance.currentUser.reload();
      })
      .catchError((e) {
        print(e);
      });
    })
    .catchError((e){
      print(e);
    });
  }

  static void changeUserDetails(String name, String address, String phone) {
    FirebaseFirestore.instance
        .collection('/users')
        .doc(AuthService.userId())
        .update({
      'name': name,
      'address': address,
      'phone': phone,
    });
  }

  static String userId() {
    return FirebaseAuth.instance.currentUser.uid;
  }
}
