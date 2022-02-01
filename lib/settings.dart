import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/startup.dart';
import 'package:app_settings/app_settings.dart';
import 'constants/textSizeConstants.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/firebase/authentication_service.dart';

// ignore: use_key_in_widget_constructors
class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  var isHighContrast = false;
  String logOutResult = "";
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Settings",
              style: TextStyle(
                  fontSize: TextSizeConstants.getadaptiveTextSize(
                      context, TextSizeConstants.buttonText))),
          backgroundColor: ColorConstants.appBar,
          automaticallyImplyLeading: true,
        ),
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: deviceWidth,
                  padding: const EdgeInsets.all(10),
                  child: Text('Account Settings',
                      style: TextStyle(
                          fontSize: 0.7 *
                              TextSizeConstants.getadaptiveTextSize(
                                  context, TextSizeConstants.bodyText),
                          fontWeight: FontWeight.w700))),
              Container(
                  width: deviceWidth,
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFFEEEEEE),
                  child: Row(children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.lock_outline),
                      onPressed: () {},
                    ),
                    InkWell(
                      child: Text('Change Password',
                          style: TextStyle(
                              fontSize: 0.7 *
                                  TextSizeConstants.getadaptiveTextSize(
                                      context, TextSizeConstants.bodyText))),
                      onTap: () {},
                    )
                  ])),
              Container(
                  width: deviceWidth,
                  padding: const EdgeInsets.all(10),
                  child: Text('Assessibility',
                      style: TextStyle(
                          fontSize: 0.7 *
                              TextSizeConstants.getadaptiveTextSize(
                                  context, TextSizeConstants.bodyText),
                          fontWeight: FontWeight.w700))),
              Container(
                  width: deviceWidth,
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFFEEEEEE),
                  child: Row(children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.grade),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProgressReport()));
                      },
                    ),
                    InkWell(
                      child: Text('Progress Report',
                          style: TextStyle(
                              fontSize: 0.7 *
                                  TextSizeConstants.getadaptiveTextSize(
                                      context, TextSizeConstants.bodyText))),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProgressReport()));
                      },
                    )
                  ])),
              // Container(
              //     width: deviceWidth,
              //     padding: const EdgeInsets.all(10),
              //     color: const Color(0xFFEEEEEE),
              //     child: Row(children: <Widget>[
              //       IconButton(
              //         icon: const Icon(Icons.color_lens),
              //         onPressed: () {
              //           OpenSettings.openAccessibilitySetting();
              //           // Navigator.push(
              //           //     context,
              //           //     MaterialPageRoute(
              //           //         builder: (context) => const TextAdjustPage()));
              //         },
              //       ),
              //       InkWell(
              //         child: Text('High Contrast',
              //             style: TextStyle(
              //                 fontSize: 0.7 *
              //                     TextSizeConstants.getadaptiveTextSize(
              //                         context, TextSizeConstants.bodyText))),
              //         onTap: () {
              //          AppSettings.openDisplaySettings();
              //         },
              //       )
              //     ])),
              Container(
                  width: deviceWidth,
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFFEEEEEE),
                  child: Row(children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.text_fields),
                      onPressed: () {
                        AppSettings
                            .openDisplaySettings(); //Display settings should have text size adjustments
                      },
                    ),
                    InkResponse(
                        child: Text('Text Size Adjustment',
                            style: TextStyle(
                                fontSize: 0.7 *
                                    TextSizeConstants.getadaptiveTextSize(
                                        context, TextSizeConstants.bodyText))),
                        onTap: () {
                          AppSettings.openDisplaySettings();
                        })
                  ])),
              Container(
                  width: deviceWidth,
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFFEEEEEE),
                  child: Row(children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {},
                    ),
                    InkWell(
                      child: Text('Log Out',
                          style: TextStyle(
                              fontSize: 0.7 *
                                  TextSizeConstants.getadaptiveTextSize(
                                      context, TextSizeConstants.bodyText))),
                      onTap: () async {
                        await AuthenticationService()
                            .signOut()
                            .then((String result) {
                          setState(() {
                            logOutResult = result;
                          });
                        });
                        print(logOutResult);
                        if (logOutResult == "Signed Out") {
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          StartUpPage()),
                                  (route) => false);
                        }
                      },
                    )
                  ])),
            ]));
  }
}

class TextAdjustPage extends StatefulWidget {
  const TextAdjustPage({Key? key}) : super(key: key);

  @override
  TextAdjustPageState createState() => TextAdjustPageState();
}

class TextAdjustPageState extends State<TextAdjustPage> {
  static double textAdjust = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ColorConstants.appBar,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Adjust your text size",
            style: TextStyle(fontSize: TextSizeConstants.memoryTitle),
          ),
          Slider.adaptive(
            value: textAdjust,
            max: 2,
            min: 0.75,
            divisions: 5,
            thumbColor: ColorConstants.appBar,
            activeColor: ColorConstants.appBar,
            label: textAdjust.toString(),
            onChangeEnd: (double value) {
              print('$value');
            },
            onChanged: (double value) {
              setState(() {
                textAdjust = value;
              });
            },
          )
        ],
      ),
    );
  }
}
