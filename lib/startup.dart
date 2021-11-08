import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/login.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/creatememory.dart';
import 'package:recollect_app/addmoment.dart';
import 'package:recollect_app/addphoto.dart';
import 'package:recollect_app/addvideo.dart';
import 'package:recollect_app/addaudio.dart';

void main() => runApp(StartUp());

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartUpPage(),
    );
  }
}

class StartUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 320.0),
              child: const Center(
                child: Text(
                  'ReCollect',
                  style: TextStyle(
                    fontSize: 64.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 68.0),
              height: 68,
              width: 230,
              child: TextButton(
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 22.0),
              height: 68,
              width: 230,
              child: TextButton(
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              height: 68,
              width: 230,
              child: TextButton(
                child: const Text(
                  'test Create memory (To be removed)',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAudioPage()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
