import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recollect_app/firebase/authentication_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNewUser(
      {required String email, required String caregiverPin}) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    return users
        .add({
          'user_email': email,
          'admin_user_email': email,
          'caregiver_pin': caregiverPin
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addNewMemory(
      {required String title,
      required String startDate,
      String? endDate,
      String? description}) {
    CollectionReference memories =
        FirebaseFirestore.instance.collection('memories');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    return memories
        .add({
          'user_email': currentUser.email,
          'title': title,
          'start_date': startDate,
          'end_date': endDate,
          'description': description,
          'moment_documents': []
        })
        .then((value) => print("Memory Added"))
        .catchError((error) => print("Failed to add memory: $error"));
  }
}
