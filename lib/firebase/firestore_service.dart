import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recollect_app/firebase/authentication_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List _memories = [];

  Future<void> addNewUser(
      {required String email, required String caregiverPin}) {
    CollectionReference users = _firestore.collection('users');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    return users
        .add({
          'user_email': email,
          'admin_user_email': email,
          'caregiver_pin': caregiverPin,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // List getUserMemories() {
  //   User? currentUser = AuthenticationService().getUser();
  //   if (currentUser == null) {
  //     throw Exception('currentUser is null');
  //   }
  //   CollectionReference memories = _firestore.collection('memories');
  //   List _memories = [
  //     {'title': 'myTitle'}
  //   ];
  //   memories
  //       .where('user_email', isEqualTo: currentUser.email)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) async {
  //     // _memories = await querySnapshot.docs.map((e) => e.data()).toList();
  //     // print("In FirestoreService: $_memories");
  //     // return _memories;
  //     querySnapshot.docs.map((e) {
  //       _memories.add(e.data());
  //       print("In FirestoreService: $_memories");
  //     });
  //   }).catchError((error) => print("Failed to obtain user's memories: $error"));

  //   return _memories;
  // }

  Future<void> addNewMemory(
      {required String title,
      required String startDate,
      String? endDate,
      String? description}) {
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    CollectionReference memories = _firestore.collection('memories');
    return memories.add({
      'user_email': currentUser.email,
      'title': title,
      'start_date': startDate,
      'end_date': endDate,
      'description': description,
    }).then((value) {
      print("Memory Added");
    }).catchError((error) => print("Failed to add memory: $error"));
  }

  // THIS ONLY WORKS WHEN FILE IS SAVED WHEN APP IS RUNNING
  // List getUserMemories() {
  //   getMemoriesFromFirebase();
  //   return _memories;
  // }

  // Future<void> getMemoriesFromFirebase() async {
  //   CollectionReference memories = _firestore.collection('memories');
  //   User? currentUser = AuthenticationService().getUser();
  //   if (currentUser == null) {
  //     throw Exception('currentUser is null');
  //   }

  //   // DocumentSnapshot snap = await memories.doc('loser').get();

  //   QuerySnapshot snapshot =
  //       await memories.where('user_email', isEqualTo: currentUser.email).get();

  //   List<QueryDocumentSnapshot> docSnapshot = snapshot.docs;

  //   if (docSnapshot.isNotEmpty) {
  //     docSnapshot.forEach((element) {
  //       _memories.add(element.data());
  //     });
  //   }
  // }
}
