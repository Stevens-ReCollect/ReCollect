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
      final _user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_user.user!.emailVerified) {
        return "Success!";
      } else {
        return "Please verify your email with the link sent to your email.";
      }
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
      final _user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirestoreService()
          .addNewUser(email: email, caregiverPin: caregiverPin, counter: 0);
      await _user.user!.sendEmailVerification();
      return "Success";
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    }
  }

  // RESET PASSWORD METHOD
  Future<String> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Success";
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    }
  }

  Future<String> validateCurrentPassword(
      String currentEmail, String currentPassword) async {
    var firebaseUser = await _firebaseAuth.currentUser;

    // placeholder for change password function
    var authCredentials = EmailAuthProvider.credential(
        email: currentEmail, password: currentPassword);

    // Issue with the actual workflow, being that the method
    // gives an error below with String? != String

    // var authCredentials = EmailAuthProvider.credential(
    //    email: firebaseUser!.email password: currentPassword);

    try {
      await firebaseUser!.reauthenticateWithCredential(authCredentials);
      return "Success";
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    }
  }

  //VALIDATE EMAIL METHOD
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

  //VALIDATE PASSWORD METHOD
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required.';
    }

    String pattern =
        r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password)) {
      return 'Password must be at least 8 characters, and must \ninclude an uppercase letter, number, and symbol.';
    }

    return null;
  }

  //VALIDATE PIN METHOD
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
  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed Out";
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
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

  //UPDATE PASSWORD METHOD
  Future<void> updatePassword(String newPassword) async {
    var firebaseUser = getUser();
    firebaseUser!.updatePassword(newPassword);
  }
}
