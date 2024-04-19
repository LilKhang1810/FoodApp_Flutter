import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String userName) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('User')
          .doc(credential.user!.uid)
          .set(
        {
          'username': userName,
          'email': email,
        },
      );
      return credential.user;
    } catch (e) {
      print('Something went wrong');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('Something went wrong');
    }
    return null;
  }

  Future<User?> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out');
    } catch (e) {
      print('Something went wrong');
    }
  }
}
