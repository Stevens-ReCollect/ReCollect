// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recollect_app/addaudio.dart';
import 'package:recollect_app/addphoto.dart';
import 'package:recollect_app/addvideo.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recollect_app/editmemory.dart';
import 'package:recollect_app/editphoto.dart';
import 'package:recollect_app/editvideo.dart';
import 'package:recollect_app/editaudio.dart';
import 'package:recollect_app/firebase/authentication_service.dart';
import 'package:recollect_app/firebase/firestore_service.dart';

import 'constants/textSizeConstants.dart';

class MemoryHomePage extends StatefulWidget {
  const MemoryHomePage({this.memoryData});
  final memoryData;

  @override
  _MemoryHomePageState createState() => _MemoryHomePageState();
}

class _MemoryHomePageState extends State<MemoryHomePage> {
  userMoments() {
    MediaQueryData queryData = MediaQuery.of(context);
    var pixelRatio = queryData.devicePixelRatio; //responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    final Stream<QuerySnapshot> _momentStream = FirebaseFirestore.instance
        .collection('moments')
        .where("memory_id", isEqualTo: widget.memoryData['doc_id'])
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _momentStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        if (snapshot.data?.size == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/polaroid_camera.png',
                width: deviceWidth * 0.9,
              ),
              Text(
                'No moments',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.bodyText),
                ),
              ),
              Text(
                'Press “+” to add moments to this memory',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.formField),
                  color: Colors.black54,
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                // print("Print data: $data");
                if (data.isEmpty) {
                  return Text("Hello");
                } else {
                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.all(
                        TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.dropDownText)),
                    // child: Slidable(
                    child: ListTile(
                      title: Text(
                        data['type'],
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: TextSizeConstants.getadaptiveTextSize(
                              context, TextSizeConstants.bodyText),
                        ),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          child: Image.network(
                            data['thumbnail_path'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              if (data['type'] == 'Photo') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPhotoPage(
                                      momentData: data,
                                    ),
                                  ),
                                );
                              } else if (data['type'] == 'Video') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditVideoPage(
                                      momentData: data,
                                    ),
                                  ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAudioPage(
                                    momentData: data,
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    momentDeleteConfirmation(
                                        data['doc_id'], data['memory_id']));
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                   ),
                  );
                }
              },
            ).toList(),
          );
        }
      },
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print('Clicked Add Photo');
        // Navigator.pushNamed(context, RouteConstants.addPhoto);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddPhotoPage(memoryData: widget.memoryData)));
        break;
      case 1:
        print('Clicked Add Video');
        // Navigator.pushNamed(context, RouteConstants.addVideo);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddVideoPage(memoryData: widget.memoryData)));
        break;
      case 2:
        print('Clicked Add Audio');
        // Navigator.pushNamed(context, RouteConstants.addAudio);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddAudioPage(memoryData: widget.memoryData)));
        break;
    }
  }

  Widget momentDeleteConfirmation(String momentId, String memoryId) {
    return AlertDialog(
      content: const Text("Are you sure you want to delete this moment?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                await FirestoreService()
                    .deleteMoment(momentId: momentId, memoryId: memoryId);
                Navigator.of(context, rootNavigator: true).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Successfully deleted moment"),
                    backgroundColor: ColorConstants.buttonColor,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(20),
                  ),
                );
              },
              child: const Text("Yes"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    ColorConstants.buttonColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorConstants.buttonText),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text("Cancel"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorConstants.formField),
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorConstants.bodyText),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget memoryDeleteConfirmation(String memoryId) {
    return AlertDialog(
      content: const Text(
          "Are you sure you want to delete this memory?\n\nNOTE: You will lose all data and media in this memory!"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                await FirestoreService().deleteMemory(memoryId: memoryId);
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Successfully deleted memory"),
                    backgroundColor: ColorConstants.buttonColor,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(20),
                  ),
                );
              },
              child: const Text("Yes"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    ColorConstants.buttonColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorConstants.buttonText),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text("Cancel"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorConstants.formField),
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorConstants.bodyText),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var pixelRatio = queryData.devicePixelRatio; //responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton<int>(
              child: Container(
                height: 2.0 *
                    TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.dropDownText),
                width: 2.0 *
                    TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.dropDownText),
                decoration: ShapeDecoration(
                  color: ColorConstants.buttonColor,
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  Icons.add,
                  color: ColorConstants.buttonText,
                  size: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.dropDownText),
                ),
              ),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  child: Text(
                    'Add Photo',
                    style: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.dropDownText),
                    ),
                  ),
                  value: 0,
                ),
                PopupMenuItem<int>(
                  child: Text(
                    'Add Video',
                    style: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.dropDownText),
                    ),
                  ),
                  value: 1,
                ),
                PopupMenuItem<int>(
                  child: Text(
                    'Add Audio',
                    style: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.dropDownText),
                    ),
                  ),
                  value: 2,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    child: Text(
                      widget.memoryData['title'],
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.memoryTitle),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditMemoryPage(memoryData: widget.memoryData),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            memoryDeleteConfirmation(
                                widget.memoryData['doc_id']));
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
            userMoments(),
          ],
        ),
      ),
    );
  }
}

class AddMomentMenu {
  static const items = <String>[
    photo,
    video,
    audio,
  ];

  static const String photo = 'Add Photo';
  static const String video = 'Add Video';
  static const String audio = 'Add Audio';
}
