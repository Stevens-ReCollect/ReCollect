import 'dart:io';
import 'dart:math';

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
      required File? file,
      String? endDate,
      String? description}) async {
    User? currentUser = AuthenticationService().getUser();
    String fileURL = 'temporary';
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    CollectionReference memories = _firestore.collection('memories');
    DocumentReference documentReference = memories.doc("null");
    await memories.add({
      'user_email': currentUser.email,
      'title': title,
      'start_date': startDate,
      'end_date': endDate,
      'description': description,
      'file_path': '',
    }).then((value) {
      documentReference = value;
      print("Memory Added");
      addId(memories);
    }).catchError((error) => print("Failed to add memory: $error"));

    //Upload file to Storage
    if (file != null) {
      await uploadThumbnail(
              file: file, user: currentUser.email, memory: documentReference.id)
          .then((url) => fileURL = url);
    }

    // await Future.delayed(const Duration(seconds: 3));

    return documentReference.update({'file_path': fileURL});
  }

  Future<void> addNewMoment(
      {required String memoryId,
      required String type,
      required File? file,
      String? description}) async {
    User? currentUser = AuthenticationService().getUser();
    String fileURL = 'temporary';
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    //Add to Firestore
    CollectionReference moments = _firestore.collection('moments');
    DocumentReference documentReference = moments.doc("null");
    await moments.add({
      'user_email': currentUser.email,
      'type': type,
      'descripton': description,
      'memory_id': memoryId,
      'file_path': '',
    }).then((value) {
      documentReference = value;
      print("Moment added: $documentReference");
      addId(moments);
    }).catchError((error) => print("Failed to add new moment: $error"));

    // print("Document Reference: $documentReference");

    //Upload file to Storage
    if (file != null) {
      await uploadFile(
              file: file,
              user: currentUser.email,
              memory: memoryId,
              moment: documentReference.id)
          .then((url) => fileURL = url);
    }

    // await Future.delayed(const Duration(seconds: 3));

    return documentReference.update({'file_path': fileURL});
  }

  Future<String> uploadFile(
      {required File file,
      required String? user,
      required String memory,
      required String moment}) async {
    String fileURL = '';
    Reference reference = _storage.ref(user! + "/" + memory + "/" + moment);
    await reference.putFile(file);
    // await Future.delayed(const Duration(seconds: 5));
    fileURL = await reference.getDownloadURL();
    print("File URL: $fileURL");
    return fileURL;
  }

  Future<String> uploadThumbnail(
      {required File file,
      required String? user,
      required String memory}) async {
    String fileURL = '';
    Reference reference =
        _storage.ref(user! + "/" + memory + "/" + "thumbnail");
    await reference.putFile(file);
    // await Future.delayed(const Duration(seconds: 5));
    fileURL = await reference.getDownloadURL();
    print("File URL: $fileURL");
    return fileURL;
  }
}
