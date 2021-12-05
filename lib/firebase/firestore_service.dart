import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recollect_app/firebase/authentication_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addId(CollectionReference collection) async {
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    return collection
        .where('user_email', isEqualTo: currentUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    if (doc.data() != null)
                      {
                        collection.doc(doc.id).update({'doc_id': doc.id})
                      }
                  })
            });
  }

  Future<void> addNewUser(
      {required String email, required String caregiverPin}) async {
    CollectionReference users = _firestore.collection('users');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    return users.add({
      'user_email': email,
      'admin_user_email': email,
      'caregiver_pin': caregiverPin,
    }).then((value) {
      print("User Added");
      addId(users);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addNewMemory(
      {required String title,
      required String startDate,
      String? endDate,
      String? description}) async {
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
      addId(memories);
    }).catchError((error) => print("Failed to add memory: $error"));
  }

  Future<void> addNewMoment(
      {required String memoryId,
      required String type,
      required File? file,
      String? description}) async {
    User? currentUser = AuthenticationService().getUser();
    String fileUrl = 'temporary';
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    //Upload file to Storage
    if (file != null) {
      uploadFile(file: file, user: currentUser.email, memory: memoryId);
    }

    Future.delayed(const Duration(milliseconds: 10000));

    //Add to Firestore
    CollectionReference moments = _firestore.collection('moments');
    return moments.add({
      'user_email': currentUser.email,
      'type': type,
      'descripton': description,
      'file_path': fileUrl,
      'memory_id': memoryId
    }).then((value) {
      print("Moment added");
      addId(moments);
    }).catchError((error) => print("Failed to add new moment: $error"));
  }

  uploadFile(
      {required File file,
      required String? user,
      required String memory}) async {
    String url = 'loser';
    // UploadTask task = _storage.ref(user! + '/' + memory).putFile(file);
    Reference reference = _storage.ref().child('$user/$memory');
    UploadTask uploadTask = reference.putFile(file);
    uploadTask.whenComplete(() {
      url = reference.getDownloadURL().toString();
    }).catchError((error) => print("Failed to upload file: $error"));
    // (await task).ref.getDownloadURL().then((value) => {url = value});
    return url;
  }
}
