import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'constants/routeConstants.dart';
import 'constants/textSizeConstants.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool isHighContrast = false;

  checkIfHighContrast(){
      if (isHighContrast == true){
              ColorConstants.appBar = const Color(0xFF000000);
              ColorConstants.buttonColor = const Color(0xFF222222);
        } 
        setState(() {
        });
    }

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
                  checkIfHighContrast();
                },
              ),
            ],
          ),
        ],
      ));
       
  }
}
