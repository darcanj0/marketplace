import 'package:clothing/helpers/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider();

  final FirebaseAuth _firebase = FirebaseAuth.instance;

  FirebaseAuth get firebase => _firebase;

  String userId = '';

  Future<void> login(Map<String, String> userData) async {
    try {
      final credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userData['email'] as String,
        password: userData['password'] as String,
      );
      userId = credentials.user?.uid ?? '';
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AppHttpException(
          msg: 'Invalid Password',
          statusCode: 400,
        );
      } else {
        throw AppHttpException(
            statusCode: 400, msg: 'An unknown error occurred');
      }
    }
  }

  Future<void> signup(Map<String, String> userData) async {
    try {
      final UserCredential credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userData['email'] as String,
        password: userData['password'] as String,
      );
      if (credentials.user == null) return;
      await credentials.user!.sendEmailVerification();
      userId = credentials.user?.uid ?? '';
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AppHttpException(
          msg: 'This email already has an account',
          statusCode: 400,
        );
      } else {
        throw AppHttpException(
            statusCode: 400, msg: 'An unknown error occurred');
      }
    }
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
