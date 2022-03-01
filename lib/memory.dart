import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:recollect_app/widgets/affirmButtons.dart';
import 'package:recollect_app/widgets/photowidget.dart';
import 'package:recollect_app/widgets/videoplayer.dart';
import 'package:recollect_app/widgets/audioplayer.dart';

class MemoryPage extends StatefulWidget {
  const MemoryPage({this.memoryData});
  final memoryData;
  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<MemoryPage> {
  var _current = 0; //TODO: Implement current moment indicator

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var pixelRatio = queryData.devicePixelRatio; //responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;

    late String _buttonController; // alerts the correct dialog
    late String affirmTitle;
    late String affirmation; // affirming message
    late Stream<QuerySnapshot>
        _currentMoment; // streams the current moment on screen

    memoryCarouselSlider() {
      Stream<QuerySnapshot> _momentStream = FirebaseFirestore.instance
          .collection('moments')
          .where("memory_id", isEqualTo: widget.memoryData['doc_id'])
          .snapshots();
      return StreamBuilder<QuerySnapshot>(
          stream: _momentStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }

            return CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1 / 1,
                height: deviceHeight,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   _current = index + 1;
                  //   _currentMoment = _momentStream;
                  // });
                },
              ),
              items: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Builder(builder: (BuildContext context) {
                  // print("Print data: $data");
                  if (data.isEmpty) {
                    return const Text("This memory is empty.");
                  } else {
                    if (data['type'] == 'Photo') {
                      return PhotoWidget(
                          data['description'], data['file_path'], data['doc_id']);
                    } else if (data['type'] == 'Video') {
                      return VideoPlayerWidget(
                          data['description'], data['file_path'], data['doc_id']);
                    } else if (data['type'] == 'Audio') {
                      return AudioPlayerWidget(
                          data['description'], '', data['file_path'], data['doc_id']);
                    } else {
                      return const SizedBox();
                    }
                  }
                });
              }).toList(),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: ColorConstants.appBar,
          title: Text(
            '', //TODO: show moment title in app bar
            style: TextStyle(
                fontSize: TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.buttonText)),
          ), //memory title
        ),
        body: SingleChildScrollView(
          // child: AspectRatio(
          //   aspectRatio: 100 / 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                SizedBox(
                  width: deviceWidth,
                  height: 0.7*deviceHeight,
                  child: Center(child: memoryCarouselSlider()),
                ),
              ],
            ),
          ),
        // )
        );
  }
}
