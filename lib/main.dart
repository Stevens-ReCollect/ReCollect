import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recollect_app/addaudio.dart';
import 'package:recollect_app/addphoto.dart';
import 'package:recollect_app/addvideo.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/creatememory.dart';
import 'package:recollect_app/login.dart';
import 'package:recollect_app/memory_example.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/startup.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:recollect_app/navigation.dart';
import 'package:recollect_app/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StartUp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReCollect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        RouteConstants.homeRoute: (context) => MyHomePage(),
        RouteConstants.memExRoute: (context) => MemoryPage(),
        RouteConstants.progressRoute: (context) => ProgressReport(),
        RouteConstants.createMemory: (context) => CreateMemoryPage(),
        RouteConstants.signupRoute: (context) => SignUpPage(),
        RouteConstants.loginRoute: (context) => LoginPage(),
        RouteConstants.addAudio: (context) => AddAudioPage(),
        RouteConstants.addVideo: (context) => AddVideoPage(),
        RouteConstants.addPhoto: (context) => AddPhotoPage(),
        RouteConstants.memoryHomeRoute: (context) => MemoryHomePage(),
        RouteConstants.navigationRoute: (context) => Navigate(),
        RouteConstants.settingsRoute: (context) => SettingsPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static late int accountMode = 0;
  createNewMemory() {
    //Create New Memory button toggle
    if (accountMode == 0) {
      return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteConstants.createMemory);
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
            onPressed: () {
              accountMode = 0;

              Navigator.of(context).pop();
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
            child: AspectRatio(
                aspectRatio: 100 / 100,
                child: Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'New Memories',
                            style: TextStyle(
                                color: ColorConstants.bodyText,
                                fontSize: TextSizeConstants.getadaptiveTextSize(
                                    context, TextSizeConstants.h2)),
                          )),
                      createNewMemory(),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteConstants.memExRoute);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                  width: 0.8 * deviceWidth,
                                  height: deviceHeight / 4,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topLeft,
                                        image: AssetImage(
                                            'lib/images/wedding-placeholder.jpg'),
                                      ))),
                              Container(
                                alignment: Alignment.bottomLeft,
                                decoration: const BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                width: 0.8 * deviceWidth,
                                height: deviceHeight / 4,
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 10),
                                child: Text(
                                  'Wedding',
                                  style: TextStyle(
                                      color: ColorConstants.buttonText,
                                      fontSize:
                                          TextSizeConstants.getadaptiveTextSize(
                                              context,
                                              TextSizeConstants.buttonText),
                                      fontWeight: FontWeight.w900),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ))));
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
          Navigator.pushNamed(context, RouteConstants.progressRoute);
        },
      );
    }
    if (accountMode == 1) {
      return SizedBox();
    }
  }
}
