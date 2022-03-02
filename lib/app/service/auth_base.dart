import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase{
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> SignInAnonymously();
  Future<void> SignOut();
  Future<User?> SignInGoogle();
  Future<User?> signInWithEmailAndPassword(email,password);
  Future<User?> createUserWithEmailAndPassword(email, password);
  Future<UserCredential>signInWithFacebook();
  //Future<UserCredential> signInWithFacebook();
}