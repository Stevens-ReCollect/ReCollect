import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'constants/routeConstants.dart';
import 'constants/textSizeConstants.dart';
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
          iconSize: 25,
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