import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recollect_app/firebase/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // AuthenticationService(this._firebaseAuth);

  get user => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //SIGN IN METHOD
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    }
  }

  //SIGN UP METHOD
  Future<String> signUp(
      {required String email,
      required String password,
      required String confirmPassword,
      required String caregiverPin}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirestoreService()
          .addNewUser(email: email, caregiverPin: caregiverPin, counter: 0);
      return "Success";
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'E-mail address is required.';
    }

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Invalid E-mail Address format.';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required.';
    }

    String pattern =
        r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password)) {
      return 'Password must be at least 8 characters, include an uppercase letter, number, and symbol.';
    }

    return null;
  }

  String? validatePin(String? caregiverPin) {
    if (caregiverPin == null || caregiverPin.isEmpty) {
      return 'Caregiver Pin is required.';
    }
    RegExp fourDigitCode = RegExp(r"(^\d{4}$)");
    if (!fourDigitCode.hasMatch(caregiverPin)) {
      return "Caregiver Pin must be a 4 digit code.";
    }
    return null;
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
