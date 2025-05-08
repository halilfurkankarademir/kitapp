import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitapp/utils/utils.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //Register function
  Future<void> createUser(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Utils().showToastError('Email zaten kayıtlı!');
      } else if (e.code == 'weak-password') {
        Utils().showToastError('Zayıf şifre!');
      }
      rethrow;
    }
  }

  //Login function
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Utils().showToastError('Geçersiz şifre veya email!');
      }
      rethrow;
    }
  }

  //Sign out function
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
