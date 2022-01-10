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
  List stepTitle = ['Sharing', 'Edit Mode', 'Story Mode', 'Accessibility', 'View Progress'];
  List stepDesc = [ "Upload memories via pictures, videos, and audio by tapping Create New Memory in the home page.",
  "Toggle between Edit and Story modes using the toggle switch on the top right. To access Edit mode, you must type in your Caregiver Pin, which gives access to the settings and creating memories.",
  "When in story mode, the application blocks users from editing their account and just allows for users to view memories for easy access.",
  "Use our accessibility tools such as text-to-speech and high contrast by enabling them in your system's settings in the top right corner of the home page.",
  "To view the progress of your loved one, go to the settings in edit mode and you will find it there!",
  ];

  

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;

    _backButton(){
    if(step > 0){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(maximumSize: Size.fromWidth(0.5*deviceWidth), primary: ColorConstants.buttonColor, padding: EdgeInsets.all(20), 
        alignment: Alignment.center,
        textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText))),
        onPressed:(){
        setState(() {
          step--; 
        });
      }, child: const Text('Back'));
    } else{
      return const SizedBox();
    }
  }

    return Scaffold(
      body: Center(
        child: Container(
          width: 0.8*deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
      [Text(((step+1).toString() +"/"+ stepTitle.length.toString()), style: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.memoryTitle))),
      SizedBox(height: 0.05*deviceHeight),
      Text(stepTitle[step], style: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.memoryTitle))),
      SizedBox(height: 0.05*deviceHeight),
      Text(stepDesc[step], style: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText))),
      SizedBox(height: 0.05*deviceHeight),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
      _backButton(),
      SizedBox( width: 0.05*deviceWidth),
      ElevatedButton(
        style: ElevatedButton.styleFrom(maximumSize: Size.fromWidth(0.5*deviceWidth), primary: ColorConstants.buttonColor, padding: EdgeInsets.all(20), 
        alignment: Alignment.center,
        textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText))),
        onPressed:(){
        setState(() {
          step++;
           
          if(step == stepTitle.length){
            Navigator.pushNamed(context, RouteConstants.homeRoute);
            step = 0;
          }
        });
      }, child: const Text('Next')),
      
      ])],
      ),
      ),
      ));
  }
  
}