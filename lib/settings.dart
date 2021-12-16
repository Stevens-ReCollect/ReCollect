import 'package:flutter/material.dart';
import 'package:recollect_app/constants/color_constants.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'constants/route_constants.dart';
import 'constants/text_size_constants.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late bool isHighContrast = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.appBar,
        title: Text('Setting', style: TextStyle(fontSize: 0.8*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText)),),
      ),
      backgroundColor: Colors.white,
      body: SettingsList(
        contentPadding: const EdgeInsets.all(10),
        sections: [
          SettingsSection(
            titlePadding: const EdgeInsets.all(10),
            subtitlePadding: const EdgeInsets.all(10),
            title: 'Account Settings',
            titleTextStyle: TextStyle(fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),),
            tiles: [
              SettingsTile(
                title: 'Change Password',
                titleTextStyle: TextStyle(fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),),
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),]),

          SettingsSection(
            titlePadding: const EdgeInsets.all(10),
            subtitlePadding: const EdgeInsets.all(10),
            title: 'Accessibility',
            titleTextStyle: TextStyle(fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),),
            tiles: [
              SettingsTile(
                title: 'Language',
                titleTextStyle: TextStyle(fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),),
                subtitle: 'English',
                subtitleTextStyle: TextStyle(fontSize: 0.6*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),),
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'High Contrast',
                switchActiveColor: ColorConstants.appBar,
                titleTextStyle: TextStyle(fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),),
                leading: const Icon(Icons.color_lens),
                switchValue: isHighContrast,
                onToggle: (bool value) {
                  isHighContrast = value;
                  if(isHighContrast == true){
                    //TODO: Figure way to send to settings on operating system
                  }
                  // setState(() {
                    
                  // });
                },
              ),
              SettingsTile(
                title: 'Text Size Adjustment',
                titleTextStyle: TextStyle(fontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),),
                leading: Icon(Icons.text_fields),
                onPressed: (BuildContext context) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TextAdjustPage()));
                },
              ),

            ],
          ),
           
        ],
      ));
       
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
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        const Text("Adjust your text size", style: TextStyle(fontSize: TextSizeConstants.memoryTitle),),
        Slider.adaptive(
        value: textAdjust,
        max: 2,
        min:0.75,
        divisions: 5,
        label: textAdjust.toString(),
        onChangeEnd: (double value) { 
          print ('$value');
         },
        onChanged: (double value) { 
          setState(() {
           textAdjust = value;
          });
         },
    
    )]));
  }
}