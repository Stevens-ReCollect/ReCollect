import 'package:flutter/material.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/main.dart';
import 'package:recollect_app/settings.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'constants/textSizeConstants.dart';

bool disableNav = false;

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceHeight = queryData.size.height;

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      navBarHeight: 0.09 * deviceHeight,
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      hideNavigationBar:
          disableNav, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

List<Widget> _buildScreens() {
  return [MyHomePage(), ProgressReport(), SettingsPage()];
}

List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.photo_library),
      iconSize: 0.8 *
          TextSizeConstants.getadaptiveTextSize(
              context, TextSizeConstants.bodyText),
      title: ("Memories"),
      inactiveColorPrimary: ColorConstants.unfavoredButton,
      activeColorPrimary: ColorConstants.buttonColor,
      textStyle: TextStyle(
          fontSize: 0.7 *
              TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText)),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.poll),
      iconSize: 0.8 *
          TextSizeConstants.getadaptiveTextSize(
              context, TextSizeConstants.bodyText),
      title: ("Progress Report"),
      inactiveColorPrimary: ColorConstants.unfavoredButton,
      activeColorPrimary: ColorConstants.buttonColor,
      textStyle: TextStyle(
          fontSize: 0.7 *
              TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText)),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.settings),
      iconSize: 0.8 *
          TextSizeConstants.getadaptiveTextSize(
              context, TextSizeConstants.bodyText),
      title: ("Settings"),
      inactiveColorPrimary: ColorConstants.unfavoredButton,
      activeColorPrimary: ColorConstants.buttonColor,
      textStyle: TextStyle(
          fontSize: 0.7 *
              TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText)),
    ),
  ];
}
