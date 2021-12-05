// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recollect_app/addphoto.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:image_picker/image_picker.dart';

import 'constants/textSizeConstants.dart';

class MemoryHomePage extends StatefulWidget {
  const MemoryHomePage({required this.memoryData});
  final memoryData;

  @override
  _MemoryHomePageState createState() => _MemoryHomePageState();
}

class _MemoryHomePageState extends State<MemoryHomePage> {
  final List<String> _moments = ['Photo', 'Video', 'Audio'];
  // final List<String> _moments = [];

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) {
  //       return;
  //     }
  //     final imageTemp = File(image.path);
  //     setState(() {
  //       this.file = imageTemp;
  //     });
  //     // Navigator.pushNamed(context, RouteConstants.addPhoto);
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => AddPhotoPage(image: file)));
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image $e');
  //   }
  //   // need to add code to add File(image.path) to Firebase
  // }

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
        Navigator.pushNamed(context, RouteConstants.addVideo);
        break;
      case 2:
        print('Clicked Add Audio');
        Navigator.pushNamed(context, RouteConstants.addAudio);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var pixelRatio = queryData.devicePixelRatio; //responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    Widget body;

    if (_moments.isNotEmpty) {
      body = ReorderableListView(
        header: Container(
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
        children: [
          for (final moment in _moments)
            Card(
              key: ValueKey(moment),
              color: Colors.white,
              elevation: 0,
              margin: EdgeInsets.all(TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.dropDownText)),
              // child: Slidable(
              child: ListTile(
                title: Text(
                  moment,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.bodyText),
                  ),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    child: Image.network(
                      'https://www.brides.com/thmb/1bR5-1Y1y0drTsbS8fhu3gYJxBQ=/1425x0/filters:no_upscale():max_bytes(200000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__brides__public__brides-services__production__2018__12__03__5c057f05648d6b2dd3b5a13a_kristen-and-jonathan-wedding22-fd1d0dc5dfa94482a9c3273b663c4a2d.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.reorder,
                  size: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.dropDownText),
                ),
              ),
              //   actionPane: const SlidableScrollActionPane(),
              //   actions: const <Widget>[
              //     IconSlideAction(
              //       caption: 'Delete',
              //       color: Colors.red,
              //       icon: Icons.delete,
              //     )
              //   ],
              //   actionExtentRatio: 1 / 1,
              // ),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          setState(
            () {
              final String moment = _moments[oldIndex];
              _moments.removeAt(oldIndex);
              _moments.insert(newIndex, moment);
            },
          );
        },
      );
    } else {
      body = SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Text(
                    '{Memory Title}',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.memoryTitle),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Text>[
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
            )
          ],
        ),
      );
    }
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
                  child: Text('Add Audio',
                      style: TextStyle(
                          fontSize: TextSizeConstants.getadaptiveTextSize(
                              context, TextSizeConstants.dropDownText))),
                  value: 2,
                ),
              ],
            ),
          ),
        ],
      ),
      body: body,
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

// void onSelected(BuildContext context, int item) {
//   switch (item) {
//     case 0:
//       print('Clicked Add Photo');
//       // Navigator.pushNamed(context, RouteConstants.addPhoto);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   AddPhotoPage(memoryData: widget.memoryData)));
//       break;
//     case 1:
//       print('Clicked Add Video');
//       Navigator.pushNamed(context, RouteConstants.addVideo);
//       break;
//     case 2:
//       print('Clicked Add Audio');
//       Navigator.pushNamed(context, RouteConstants.addAudio);
//       break;
//   }
// }

// Future pickVideo() async {
//   final ImagePicker _picker = ImagePicker();
//   final image = await _picker.pickVideo(source: ImageSource.gallery);
//   if (image == null) {
//     return;
//   }
//   // need to add code to add File(image.path) to Firebase
// }
