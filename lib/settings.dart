import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'constants/routeConstants.dart';
import 'constants/textSizeConstants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.memoryTitle),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
