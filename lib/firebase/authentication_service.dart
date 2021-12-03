import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recollect_app/firebase/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // AuthenticationService(this._firebaseAuth);

  get user => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await FirestoreService().getUserMemories();
      return getUser();
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    }
  }

  //SIGN UP METHOD
  Future signUp(
      {required String email,
      required String password,
      required String caregiverPin}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirestoreService()
          .addNewUser(email: email, caregiverPin: caregiverPin);
      await FirestoreService().getUserMemories();
      return getUser();
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed Out";
    } on FirebaseAuthException catch (ex) {
      return ex.message;
    }
  }

  //GET USER METHOD
  User? getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }
}
