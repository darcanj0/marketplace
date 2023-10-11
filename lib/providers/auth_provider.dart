import 'package:clothing/helpers/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  AuthProvider();

  final FirebaseAuth _firebase = FirebaseAuth.instance;

  FirebaseAuth get firebase => _firebase;

  Future<void> login(Map<String, String> userData) async {
    try {
      final credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userData['email'] as String,
        password: userData['password'] as String,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AppHttpException(
          msg: 'The password provided is too weak.',
          statusCode: 400,
        );
      } else if (e.code == 'email-already-in-use') {
        throw AppHttpException(
          msg: 'The account already exists for that email.',
          statusCode: 400,
        );
      }
    } catch (e) {
      throw AppHttpException(statusCode: 400, msg: 'An unknown error occurred');
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AppHttpException(
          msg: 'No user found for that email.',
          statusCode: 401,
        );
      } else if (e.code == 'wrong-password') {
        throw AppHttpException(
          msg: 'Wrong password provided for that user.',
          statusCode: 401,
        );
      }
    } catch (e) {
      throw AppHttpException(statusCode: 400, msg: 'An unknown error occurred');
    }
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
