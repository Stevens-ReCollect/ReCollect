import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/changepassword.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/forgotpassword.dart';
import 'package:recollect_app/login.dart';
import 'package:recollect_app/main.dart';
import 'package:recollect_app/memory.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/creatememory.dart';
import 'package:recollect_app/addphoto.dart';
import 'package:recollect_app/addvideo.dart';
import 'package:recollect_app/addaudio.dart';
import 'package:recollect_app/navigation.dart';
import 'package:recollect_app/settings.dart';
import 'package:recollect_app/tutorial.dart';
import 'constants/textSizeConstants.dart';

class StartUp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  StartUp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReCollect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StartUpPage(),
      routes: {
        RouteConstants.homeRoute: (context) => MyHomePage(),
        RouteConstants.memExRoute: (context) => MemoryPage(),
        RouteConstants.progressRoute: (context) => ProgressReport(),
        RouteConstants.createMemory: (context) => CreateMemoryPage(),
        RouteConstants.signupRoute: (context) => SignUpPage(),
        RouteConstants.loginRoute: (context) => LogInPage(),
        RouteConstants.addAudio: (context) => AddAudioPage(),
        RouteConstants.addVideo: (context) => AddVideoPage(),
        // RouteConstants.addPhoto: (context) => AddPhotoPage(),
        RouteConstants.memoryHomeRoute: (context) => MemoryHomePage(),
        RouteConstants.navigationRoute: (context) => Navigate(),
        RouteConstants.settingsRoute: (context) => SettingsPage(),
        RouteConstants.tutorialRoute: (context) => Tutorial(),
        RouteConstants.changeRoute: (context) => ChangePasswordPage(),
        RouteConstants.forgotRoute: (context) => ForgotPasswordPage(),
      },
    );
  }
}

class StartUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              height: 0.3 * deviceWidth,
              child: Center(
                  child: Image.asset(
                'lib/assets/recollect_logo.png',
                width: 0.3 * deviceWidth,
              ))),
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                'ReCollect',
                style: TextStyle(
                  fontSize: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.h1),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            height: 2.5 * TextSizeConstants.bodyText,
            width: 0.6 * deviceWidth,
            child: TextButton(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.bodyText),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    ColorConstants.buttonColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorConstants.buttonText),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteConstants.signupRoute);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 22.0),
            height: 2.5 * TextSizeConstants.bodyText,
            width: 0.6 * deviceWidth,
            child: TextButton(
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.bodyText),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    ColorConstants.buttonColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorConstants.buttonText),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteConstants.loginRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
