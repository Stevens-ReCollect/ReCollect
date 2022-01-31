import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
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

    Widget _affirmingResponse(BuildContext context) {
      if (_buttonController == "Yes") {
        affirmTitle = "Great job!";
        affirmation = "Amazing progress.";
      } else if (_buttonController == "Maybe") {
        affirmTitle = "All progress is good progress!";
        affirmation = "Swipe through to see if more moments will help.";
      } else {
        affirmTitle = "It's okay!";
        affirmation = "We can always come back to this moment.";
      }
      return AlertDialog(
          title: Text(
            affirmTitle,
            style: TextStyle(
              fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            affirmation,
            style: TextStyle(
              fontSize: 0.8 *
                  TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.bodyText),
            ),
            textAlign: TextAlign.left,
          ),
          contentPadding: EdgeInsets.all(TextSizeConstants.getadaptiveTextSize(
              context, TextSizeConstants.bodyText)),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  primary: ColorConstants.buttonColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay',
                  style: TextStyle(
                      fontSize: 0.7 *
                          TextSizeConstants.getadaptiveTextSize(
                              context, TextSizeConstants.buttonText))),
            )
          ]);
    }

    memoryCarouselSlider() {
      final Stream<QuerySnapshot> _momentStream = FirebaseFirestore.instance
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
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index + 1;
                    });
                  }),
              items: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print("Print data: $data");
                if (data.isEmpty) {
                  return const Text("This memory is empty.");
                } else {
                  if (data['type'] == 'Photo') {
                    return PhotoWidget(data['description'], data['file_path']);
                  } else if (data['type'] == 'Video') {
                    return VideoPlayerWidget(
                        data['description'], data['file_path']);
                  } else if (data['type'] == 'Audio') {
                    return AudioPlayerWidget(
                        data['description'], '', data['file_path']);
                  } else {
                    return const SizedBox();
                  }
                }
              }).toList(),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: ColorConstants.appBar,
          title: Text(
            '',
            style: TextStyle(
                fontSize: TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.buttonText)),
          ), //memory title
        ),
        body: SingleChildScrollView(
          child: AspectRatio(
            aspectRatio: 100 / 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.h2),
                ),
                SizedBox(
                  width: 0.8 * deviceWidth,
                  height: 0.6 * deviceHeight,
                  child: Center(child: memoryCarouselSlider()),
                ),
                SizedBox(height: deviceHeight / 80),
                Text(
                  'Do you remember?',
                  style: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.bodyText)),
                ),
                SizedBox(height: deviceHeight / 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _buttonController = "Yes";
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _affirmingResponse(context));
                      },
                      child: const Text('Yes'),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(deviceWidth / 40),
                          primary: ColorConstants.buttonColor,
                          textStyle: TextStyle(
                              fontSize: 0.9 *
                                  TextSizeConstants.getadaptiveTextSize(
                                      context, TextSizeConstants.buttonText))),
                    ),
                    SizedBox(
                        width: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.bodyText)),
                    ElevatedButton(
                        onPressed: () {
                          _buttonController = "No";
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _affirmingResponse(context));
                        },
                        child: const Text("No"),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(deviceWidth / 40),
                            primary: ColorConstants.unfavoredButton,
                            textStyle: TextStyle(
                                fontSize: 0.9 *
                                    TextSizeConstants.getadaptiveTextSize(
                                        context,
                                        TextSizeConstants.buttonText)))),
                    SizedBox(
                        width: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.bodyText)),
                    ElevatedButton(
                        onPressed: () {
                          _buttonController = "Maybe";
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _affirmingResponse(context));
                        },
                        child: const Text("Maybe"),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(deviceWidth / 40),
                            primary: ColorConstants.unfavoredButton,
                            textStyle: TextStyle(
                                fontSize: 0.9 *
                                    TextSizeConstants.getadaptiveTextSize(
                                        context,
                                        TextSizeConstants.buttonText)))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
