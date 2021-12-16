import 'package:flutter/material.dart';
import 'package:recollect_app/constants/color_constants.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'constants/route_constants.dart';
import 'constants/text_size_constants.dart';
import 'package:recollect_app/settings.dart';

class Navigate extends StatefulWidget {
  @override
  State<Navigate> createState() => NavigateState();
}

class NavigateState extends State<Navigate> {
  int currentIndex = 0;
  final screens = [MyHomePage(), ProgressReport(), SettingsPage()];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: ColorConstants.buttonColor,
          unselectedItemColor: ColorConstants.buttonColor,
          selectedFontSize: 0.7*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
          unselectedFontSize: 0.6*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
          iconSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
          onTap: (index) => setState(() => currentIndex = index),
          currentIndex: currentIndex,
          //onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Progress Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      );
}
