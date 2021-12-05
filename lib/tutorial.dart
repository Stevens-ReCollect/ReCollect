import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';

import 'constants/textSizeConstants.dart';

class Tutorial extends StatefulWidget{
  @override
  State<Tutorial> createState() => TutorialState(); 
}

class TutorialState extends State<Tutorial>{
  int step = 0;
  List stepTitle = ['Getting Started', 'Sharing', 'Secure', 'Accessible', 'Community'];
  List stepDesc = ['Sign up with a caregiver pin to access your settings.',
  'Upload memories via pictures, videos, and audio by tapping Create New Memory.',
  'Toggle between Edit and Story modes using the toggle switch on the top right. Edit mode gives access to the settings and creating memories while story mode shows only existing memories for no tampering.',
  'Use our accessibility tools such as text-to-speech and high contrast by enabling them in your system’s settings.',
  'As an admin, add other caregivers to contribute more memories through our settings.'];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: 0.8*deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
      [Text(stepTitle[step], style: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.memoryTitle))),
      SizedBox(height: 0.05*deviceHeight),
      Text(stepDesc[step], style: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText))),
      SizedBox(height: 0.05*deviceHeight),
      ElevatedButton(
        style: ElevatedButton.styleFrom(maximumSize: Size.fromWidth(0.5*deviceWidth), primary: ColorConstants.buttonColor, padding: EdgeInsets.all(20), 
        alignment: Alignment.center,
        textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText))),
        onPressed:(){
        setState(() {
          step++;
           
          if(step == stepTitle.length){
            Navigator.pushNamed(context, RouteConstants.signupRoute);
            step = 0;
          }
        });
      }, child: const Text('Next'))],
      ),
      ),
      ));
  }
  
}