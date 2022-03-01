import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/firebase/authentication_service.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:video_player/video_player.dart';

class AffirmButtonsWidget extends StatelessWidget {
  AffirmButtonsWidget(this.doc_id);
  final doc_id;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // METHOD TO GET THE CORRECT MOMENT COUNTER FOR YES, NO, AND MAYBE
  Future<int> getMomentCounter(
      {required String id, required String label}) async {
    CollectionReference moments = _firestore.collection('moments');
    User? currentUser = AuthenticationService().getUser();
    int counter = 0;
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }

    await moments
        .where('doc_id', isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    if (doc.data() != null)
                      {
                        if (label == 'yes')
                          {counter = doc['yes']}
                        else if (label == 'no')
                          {counter = doc['no']}
                        else
                          {counter = doc['maybe']}
                      }
                  })
            });

    return counter;
  }

  late String _buttonController; // alerts the correct dialog

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    int momentCounter = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
              onPressed: () async {
                _buttonController = "Yes";
                FirestoreService().yesCounter(
                    momentID: doc_id,
                    counter:
                        await getMomentCounter(id: doc_id, label: "yes") + 1);
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        affirmingResponse(context));
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
                onPressed: () async {
                  _buttonController = "No";
                  FirestoreService().noCounter(
                      momentID: doc_id,
                      counter:
                          await getMomentCounter(id: doc_id, label: "no") + 1);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          affirmingResponse(context));
                },
                child: const Text("No"),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(deviceWidth / 40),
                    primary: ColorConstants.unfavoredButton,
                    textStyle: TextStyle(
                        fontSize: 0.9 *
                            TextSizeConstants.getadaptiveTextSize(
                                context, TextSizeConstants.buttonText)))),
            SizedBox(
                width: TextSizeConstants.getadaptiveTextSize(
                    context, TextSizeConstants.bodyText)),
            ElevatedButton(
                onPressed: () async {
                  _buttonController = "Maybe";
                  FirestoreService().maybeCounter(
                      momentID: doc_id,
                      counter:
                          await getMomentCounter(id: doc_id, label: "maybe") +
                              1);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          affirmingResponse(context));
                },
                child: const Text("Maybe"),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(deviceWidth / 40),
                    primary: ColorConstants.unfavoredButton,
                    textStyle: TextStyle(
                        fontSize: 0.9 *
                            TextSizeConstants.getadaptiveTextSize(
                                context, TextSizeConstants.buttonText)))),
          ],
        )
      ],
    );
  }

  Widget affirmingResponse(BuildContext context) {
    late String affirmTitle;
    late String affirmation;
    _buttonController = "";
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
}
