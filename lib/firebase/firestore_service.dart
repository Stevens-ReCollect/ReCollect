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

  Future<void> editMemory(
      {required String memoryId,
      String? title,
      String? startDate,
      String? endDate,
      String? description,
      File? thumbnail}) {
    CollectionReference memories = _firestore.collection('memories');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    String newUrl = "";

    if (thumbnail != null) {
      uploadFile(
              file: thumbnail,
              user: currentUser.email,
              memory: memoryId,
              moment: "momentId")
          .then((url) => newUrl = url);
    }

    if (newUrl != "") {
      memories
          .doc(memoryId)
          .update({'file_path': newUrl})
          .then((value) => print("Memory Updated"))
          .catchError((error) => print("Failed to update memory $error"));
    }

    return memories
        .doc(memoryId)
        .update({
          'title': title,
          'start_date': startDate,
          'end_date': endDate,
          'description': description
        })
        .then((value) => print("Memory Updated"))
        .catchError((error) => print("Failed to update memory: $error"));
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
      'description': description,
      'memory_id': memoryId,
      'file_path': '',
    }).then((value) {
      documentReference = value;
      print("Moment added: $documentReference");
      addId(moments);
    }).catchError((error) => print("Failed to add new moment: $error"));

    //Upload file to Storage
    if (file != null) {
      await uploadFile(
              file: file,
              user: currentUser.email,
              memory: memoryId,
              moment: documentReference.id)
          .then((url) => fileURL = url);
    }

    return documentReference.update({'file_path': fileURL});
  }

  Future<void> editMoment(
      {required String memoryId,
      required String momentId,
      File? file,
      String? description}) async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    String newUrl = "";

    if (file != null) {
      await uploadFile(
              file: file,
              user: currentUser.email,
              memory: memoryId,
              moment: momentId)
          .then((url) => newUrl = url);
    }

    if (newUrl != "") {
      moments
          .doc(momentId)
          .update({'file_path': newUrl})
          .then((value) => print("Moment Updated"))
          .catchError((error) => print("Failed to update moment $error"));
    }

    return moments
        .doc(momentId)
        .update({'description': description})
        .then((value) => print("Moment Updated"))
        .catchError((error) => print("Failed to update moment $error"));
  }

  Future<void> deleteMoment(
      {required String momentId, required String memoryId}) {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    _storage
        .ref(currentUser.email! + "/" + memoryId + "/" + momentId)
        .delete()
        .then((value) => print("Moment file deleted"))
        .catchError((error) => print("Failed to delete moment file: $error"));
    return moments
        .doc(momentId)
        .delete()
        .then((value) => print("Moment Deleted"))
        .catchError((error) => print("Failed to delete moment: $error"));
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
