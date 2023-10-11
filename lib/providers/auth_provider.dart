import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseDatabase db = FirebaseDatabase.instance;

  Future<void> login() async {}
  Future<void> signup() async {}
}
