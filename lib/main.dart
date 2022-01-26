// ignore_for_file: prefer_const_constructors, unnecessary_string_escapes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recollect_app/changepassword.dart';
import 'package:recollect_app/firebase/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:recollect_app/addaudio.dart';
import 'package:recollect_app/addphoto.dart';
import 'package:recollect_app/addvideo.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/creatememory.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:recollect_app/login.dart';
import 'package:recollect_app/memory_example.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/startup.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:recollect_app/navigation.dart';
import 'package:recollect_app/settings.dart';
import 'package:recollect_app/tutorial.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StartUp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReCollect',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(),
      routes: {
        '/auth': (context) => AuthenticationWrapper(),
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
      },
      // ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firebaseUser = Provider.of<AuthenticationService>(context);

    return StreamBuilder<User?>(
      stream: _firebaseUser.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? LogInPage() : MyHomePage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // final List _memories = FirestoreService().getUserMemories();
  static late int accountMode = 0;
  TextEditingController _pin = TextEditingController();

  String pinResult = "";

  userMemories() {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    User? currentUser = AuthenticationService().getUser();
    if (currentUser == null) {
      throw Exception('currentUser is null');
    }
    final Stream<QuerySnapshot> _memoryStream = FirebaseFirestore.instance
        .collection('memories')
        .where("user_email", isEqualTo: currentUser.email)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _memoryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            // return Text(data['title']);
            if (data['file_path'] == null) {
              return InkWell(
                onTap: () {
                  if (accountMode == 0) {
                    // Navigator.pushNamed(
                    //     context, RouteConstants.memoryHomeRoute);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MemoryHomePage(memoryData: data)));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MemoryPage()));
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 0.8 * deviceWidth,
                        height: deviceHeight / 4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            image: AssetImage('lib/images/FallLeaves.jpg'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: 0.8 * deviceWidth,
                      height: deviceHeight / 4,
                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        data['title'],
                        style: TextStyle(
                            color: ColorConstants.buttonText,
                            fontSize: TextSizeConstants.getadaptiveTextSize(
                                context, TextSizeConstants.buttonText),
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  if (accountMode == 0) {
                    // Navigator.pushNamed(
                    //     context, RouteConstants.memoryHomeRoute);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MemoryHomePage(memoryData: data)));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MemoryPage()));
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 0.8 * deviceWidth,
                        height: deviceHeight / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            image: NetworkImage(data['file_path']),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: 0.8 * deviceWidth,
                      height: deviceHeight / 4,
                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        data['title'],
                        style: TextStyle(
                            color: ColorConstants.buttonText,
                            fontSize: TextSizeConstants.getadaptiveTextSize(
                                context, TextSizeConstants.buttonText),
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              );
            }
          }).toList(),
        );
      },
    );
  }

  createNewMemory() {
    //Create New Memory button toggle
    if (accountMode == 0) {
      return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateMemoryPage()));
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  primary: ColorConstants.buttonColor,
                  textStyle: TextStyle(
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.buttonText))),
              child: Text('Create New Memory')));
    }
    if (accountMode == 1) {
      return SizedBox();
    }
  }

  caregiverPin(BuildContext context) {
    //Caregiver Pin pop up
    return AlertDialog(
        title: Text('Enter Caregiver Pin before entering Edit Mode.',
            style: TextStyle(
              fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
            )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _pin,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter pin',
                labelStyle: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.formField)),
                hintText: '####',
                hintStyle: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.formField)),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                primary: ColorConstants.buttonColor),
            onPressed: () async {
              await FirestoreService()
                  .checkPin(pin: _pin.text)
                  .then((String result) {
                setState(() {
                  pinResult = result;
                });
              });
              //print(pinResult);
              if (pinResult == "Success") {
                accountMode = 0;

                Navigator.of(context).pop();
                _pin.clear();
              } else {
                _pin.clear();
              }
            },
            child: Text('Continue',
                style: TextStyle(
                    fontSize: 0.7 *
                        TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.buttonText))),
          )
        ]);
  }

  @override
  void initState() {
    toggleColors(accountMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
          // App bar properties
          // title: Text(widget.title),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 300,
          backgroundColor: ColorConstants.appBar,
          actions: <Widget>[
            Row(
              children: <Widget>[
                Listener(
                    // onPointerDown: ColorConstants().toggleColors(value),
                    child: ToggleSwitch(
                  //Toggle between modes
                  minWidth: 0.3 * deviceWidth,
                  changeOnTap: true,
                  inactiveBgColor: Colors.white,
                  dividerColor: Colors.black,
                  activeBgColor: [
                    ColorConstants.buttonColor
                  ], //toggle colors stuck :(
                  initialLabelIndex: accountMode,
                  fontSize: 0.7 *
                      TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.buttonText),
                  totalSwitches: 2,
                  labels: const ['Edit Mode', 'Story Mode'],
                  onToggle: (value) {
                    //  print('switched to: $value');
                    toggleColors(value);
                    accountMode = value;
                    if (accountMode == 0) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) =>
                            caregiverPin(context),
                      );
                    }
                  },
                )),
                //   SizedBox(
                //    width: 0.38*deviceWidth,
                //  ),
                createSettings(),
              ],
            ),
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.

            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'New Memories',
                  style: TextStyle(
                    color: ColorConstants.bodyText,
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.h2),
                  ),
                ),
              ),
              createNewMemory(),
              userMemories(),
            ],
          ),
        ),
      ),
    );
  }

  toggleColors(int value) {
    if (value == 0) {
      //Attempt at toggle
      ColorConstants.appBar = const Color(0xFF00CB5D);
      ColorConstants.buttonColor = const Color(0xFF308C39);
    }
    if (value == 1) {
      ColorConstants.appBar = const Color(0xFF3065FC);
      ColorConstants.buttonColor = const Color(0xFF30658C);
    }
    setState(() {});
  }

  createSettings() {
    if (accountMode == 0) {
      //settings on toggle
      return IconButton(
        icon: Icon(Icons.settings),
        iconSize: TextSizeConstants.getadaptiveTextSize(
            context, TextSizeConstants.buttonText), //Settings Icon
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SettingsPage()));
        },
      );
    }
    if (accountMode == 1) {
      return SizedBox();
    }
  }
}
