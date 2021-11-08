import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/login.dart';
import 'package:recollect_app/main.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/creatememory.dart';
import 'package:recollect_app/addmoment.dart';
import 'package:recollect_app/addphoto.dart';
import 'package:recollect_app/addvideo.dart';
import 'package:recollect_app/addaudio.dart';

import 'memory_example.dart';

class StartUp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  StartUp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReCollect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartUpPage(),
      routes: {
      RouteConstants.homeRoute: (context) => MyHomePage(),
      RouteConstants.memExRoute: (context) => MemoryPage(),
      RouteConstants.progressRoute: (context) => ProgressReport(),
      RouteConstants.createMemory: (context) => CreateMemoryPage(),
      RouteConstants.signupRoute: (context) => SignUpPage(),
      RouteConstants.loginRoute: (context) => LoginPage(),
      RouteConstants.addMoment: (context) => AddMomentPage(),
      RouteConstants.addAudio: (context) => AddAudioPage(),
      RouteConstants.addVideo: (context) => AddVideoPage(),
      RouteConstants.addPhoto: (context) => AddPhotoPage(),
      RouteConstants.memoryHomeRoute: (context) => MemoryHomePage(),
      },
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
                  Navigator.pushNamed(
                    context, RouteConstants.signupRoute);
                
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
                  Navigator.pushNamed(
                    context, RouteConstants.loginRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
