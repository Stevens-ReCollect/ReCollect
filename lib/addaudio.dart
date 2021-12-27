import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/signup.dart';

import 'constants/routeConstants.dart';
import 'constants/textSizeConstants.dart';

class AddAudioPage extends StatefulWidget {
  @override
  _AddAudioPageState createState() => _AddAudioPageState();
}

class _AddAudioPageState extends State<AddAudioPage> {
  String _description = '';

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);//responsive sizing
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50.0, left: 10.0),
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  '{Selected Audio}',
                  style: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.memoryTitle),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Container(
              width: 0.8*deviceWidth,
              margin: const EdgeInsets.only(top: 30.0, left: 0.0),
              child: TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(), 
                    labelText: 'Title',
                    labelStyle: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.formField)),
                    ),
              ),
            ),
            Container(
              height: 0.3*deviceHeight,
              width: 0.8*deviceWidth,
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
              child: TextField(
                maxLines: 15,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Description',
                  labelStyle: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.formField)),
                  hintText: 'Description',
                  hintStyle:TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.formField)),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150.0, left: 0.0),
              width: 0.4*deviceWidth,
              child: TextButton(
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      ColorConstants.buttonColor),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      ColorConstants.buttonText),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RouteConstants.memoryHomeRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
