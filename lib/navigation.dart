import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'constants/routeConstants.dart';
import 'constants/textSizeConstants.dart';
import 'package:recollect_app/settings.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
          selectedFontSize: 0.6 *
              TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
          unselectedFontSize: 0.5 *
              TextSizeConstants.getadaptiveTextSize(
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
              icon: Icon(Icons.poll),
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

//PersistentTabController _controller = PersistentTabController(initialIndex: 0);

/*class Navigate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [MyHomePage(), ProgressReport(), SettingsPage()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: ("Home"),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.poll),
      title: ("Progress Report"),
    ),
    PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        onPressed: (context) {
          pushNewScreen(context!, screen: SettingsPage(), withNavBar: true);
        }),
  ];
}
*/