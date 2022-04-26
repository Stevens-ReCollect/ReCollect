import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recollect_app/firebase/authentication_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  var correctPin;

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

  // add a Counter for users that are signing in
  Future<void> editCounter(
      {required String email, required String password}) async {
    CollectionReference users = _firestore.collection('users');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    return users
        .where('user_email', isEqualTo: currentUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    if (doc.data() != null)
                      {
                        users.doc(doc.id).update({'counter': 1})
                      }
                  })
            });
  }

  // get the current Counter number for a user
  Future<int> getCounter(
      {required String email, required String password}) async {
    CollectionReference users = _firestore.collection('users');
    User? currentUser = AuthenticationService().getUser();
    int counter = 0;
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    await users
        .where('user_email', isEqualTo: currentUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    if (doc.data() != null)
                      {
                        counter = doc['counter']
                        // users.doc(doc.id).get('counter'})
                      }
                  })
            });
    return counter;
  }

  Future<void> yesCounter(
      {required String momentID, required int? counter}) async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    return moments
        .doc(momentID)
        .update({
          'yes': counter,
        })
        .then((value) => print("Moment Yes Updated"))
        .catchError((error) => print("Failed to update Moment: $error"));
  }

  Future<void> noCounter(
      {required String momentID, required int? counter}) async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    return moments
        .doc(momentID)
        .update({
          'no': counter,
        })
        .then((value) => print("Moment No Updated"))
        .catchError((error) => print("Failed to update Moment: $error"));
  }

  Future<void> maybeCounter(
      {required String momentID, required int? counter}) async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    return moments
        .doc(momentID)
        .update({
          'maybe': counter,
        })
        .then((value) => print("Moment Maybe Updated"))
        .catchError((error) => print("Failed to update Moment: $error"));
  }

  Future<void> addNewUser(
      {required String email,
      required String caregiverPin,
      required int counter}) async {
    CollectionReference users = _firestore.collection('users');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    return users.add({
      'user_email': email,
      'admin_user_email': email,
      'caregiver_pin': caregiverPin,
      'counter': 0,
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
      await uploadFile(
              file: file,
              user: currentUser.email,
              memory: documentReference.id,
              moment: "memory-thumbnail")
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
      File? thumbnail}) async {
    CollectionReference memories = _firestore.collection('memories');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    String newUrl = "";

    if (thumbnail != null) {
      await uploadFile(
              file: thumbnail,
              user: currentUser.email,
              memory: memoryId,
              moment: "memory-thumbnail")
          .then((url) => newUrl = url);
    }

    if (newUrl != "") {
      await memories
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
          'description': description,
        })
        .then((value) => print("Memory Updated"))
        .catchError((error) => print("Failed to update memory: $error"));
  }

  Future<void> deleteMemory({required String memoryId}) async {
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    CollectionReference memories = _firestore.collection('memories');
    CollectionReference moments = _firestore.collection('moments');
    deleteMoment(momentId: "thumbnail", memoryId: memoryId);
    moments.where('memory_id', isEqualTo: memoryId).get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
              if (doc.data() != null) {
                deleteMoment(momentId: doc.id, memoryId: memoryId);
              }
            }));
    return memories
        .doc(memoryId)
        .delete()
        .then((value) => print("Memory Deleted"))
        .catchError((error) => print("Failed to delete memory: $error"));
  }

  Future<void> memoryViews(
      {required String memoryId, required int? views}) async {
    CollectionReference memories = _firestore.collection('memories');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    return memories
        .doc(memoryId)
        .update({
          'views': views,
        })
        .then((value) => print("Memory Updated"))
        .catchError((error) => print("Failed to update memory: $error"));
  }

  Future<List> getMoments({required String memoryId}) async {
    CollectionReference momentsCollection = _firestore.collection('moments');
    List moments = [];
    await momentsCollection.where('memory_id', isEqualTo: memoryId).get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) => {
              if (doc.exists) {moments.add(doc.data())}
            }));
    return moments;
  }

  Future<void> addNewMoment(
      {required String memoryId,
      required String type,
      required File? file,
      required File? thumbnail,
      String? description,
      String? name}) async {
    User? currentUser = AuthenticationService().getUser();
    String fileURL = 'temporary';
    String thumbnailURL = 'temporary';
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    //Add to Firestore
    CollectionReference moments = _firestore.collection('moments');
    DocumentReference documentReference = moments.doc("null");
    await moments.add({
      'user_email': currentUser.email,
      'name': name,
      'type': type,
      'description': description,
      'memory_id': memoryId,
      'file_path': '',
      'thumbnail_path': '',
      'yes': 0,
      'no': 0,
      'maybe': 0,
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
    if (thumbnail != null) {
      await uploadFile(
              file: thumbnail,
              user: currentUser.email,
              memory: memoryId,
              moment: documentReference.id + 'thumbnail')
          .then((url) => thumbnailURL = url);
    }
    return documentReference
        .update({'file_path': fileURL, 'thumbnail_path': thumbnailURL});
  }

  Future<void> editMoment(
      {required String memoryId,
      required String momentId,
      File? file,
      File? thumbnail,
      String? description,
      String? name}) async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    String newUrl = "";
    String newThumbnailUrl = "";

    if (file != null) {
      await uploadFile(
              file: file,
              user: currentUser.email,
              memory: memoryId,
              moment: momentId)
          .then((url) => newUrl = url);
    }
    if (thumbnail != null) {
      await uploadFile(
              file: thumbnail,
              user: currentUser.email,
              memory: memoryId,
              moment: momentId + 'thumbnail')
          .then((url) => newThumbnailUrl = url);
    }
    if (newUrl != "") {
      await moments
          .doc(momentId)
          .update({'file_path': newUrl})
          .then((value) => print('Moment Updated'))
          .catchError((e) => print('Moment failed to update: $e'));
    }
    if (name != "") {
      await moments
          .doc(momentId)
          .update({'name': name})
          .then((value) => print('Moment Updated'))
          .catchError((e) => print('Moment failed to update: $e'));
    }
    if (newThumbnailUrl != "") {
      await moments
          .doc(momentId)
          .update({'thumbnail_path': newThumbnailUrl})
          .then((value) => print('Moment Updated'))
          .catchError((e) => print('Moment failed to update: $e'));
    }
    return moments
        .doc(momentId)
        .update({'description': description})
        .then((value) => print('Moment Updated'))
        .catchError((e) => print('Moment failed to update: $e'));
  }

  Future<void> deleteMoment(
      {required String momentId, required String memoryId}) async {
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
    _storage
        .ref(currentUser.email! + "/" + memoryId + "/" + momentId + 'thumbnail')
        .delete()
        .then((value) => print("Moment file deleted"))
        .catchError((error) => print("Failed to delete moment file: $error"));
    return moments
        .doc(momentId)
        .delete()
        .then((value) => print("Moment doc deleted"))
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

  Future<String> checkPin({required String pin}) async {
    CollectionReference users = _firestore.collection('users');
    User? currentUser = AuthenticationService().getUser();
    await users
        .where('user_email', isEqualTo: currentUser!.email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    if (doc.data() != null) {correctPin = doc['caregiver_pin']}
                  })
            });
    if (correctPin == pin) {
      return "Success";
    }
    return "fail";
  }

  Future<num> getOverallRememberanceRate() async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    num yes = 0;
    num no = 0;
    num maybe = 0;
    await moments
        .where('user_email', isEqualTo: currentUser!.email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                yes = yes + doc['yes'];
                no = no + doc['no'];
                maybe = maybe + doc['maybe'];
              })
            });
    print('Yes Count: $yes');
    print('No Count: $no');
    print('Maybe Count: $maybe');
    return (yes / (yes + no + maybe)) * 100;
  }

  Future<num> getPhotoRememberanceRate() async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    num yes = 0;
    num no = 0;
    num maybe = 0;
    await moments
        .where('user_email', isEqualTo: currentUser!.email)
        .where('type', isEqualTo: 'Photo')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                yes = yes + doc['yes'];
                no = no + doc['no'];
                maybe = maybe + doc['maybe'];
              })
            });
    print('Yes Count: $yes');
    print('No Count: $no');
    print('Maybe Count: $maybe');
    return (yes / (yes + no + maybe)) * 100;
  }

  Future<num> getVideoRememberanceRate() async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    num yes = 0;
    num no = 0;
    num maybe = 0;
    await moments
        .where('user_email', isEqualTo: currentUser!.email)
        .where('type', isEqualTo: 'Video')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                yes = yes + doc['yes'];
                no = no + doc['no'];
                maybe = maybe + doc['maybe'];
              })
            });
    print('Yes Count: $yes');
    print('No Count: $no');
    print('Maybe Count: $maybe');
    return (yes / (yes + no + maybe)) * 100;
  }

  Future<num> getAudioRememberanceRate() async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    num yes = 0;
    num no = 0;
    num maybe = 0;
    await moments
        .where('user_email', isEqualTo: currentUser!.email)
        .where('type', isEqualTo: 'Audio')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                yes = yes + doc['yes'];
                no = no + doc['no'];
                maybe = maybe + doc['maybe'];
              })
            });
    print('Yes Count: $yes');
    print('No Count: $no');
    print('Maybe Count: $maybe');
    return (yes / (yes + no + maybe)) * 100;
  }
}
