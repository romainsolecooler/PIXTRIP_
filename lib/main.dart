import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/common/messages.dart';

import 'package:pixtrip/pages/home.dart';
import 'package:pixtrip/pages/trips.dart';
import 'package:pixtrip/pages/profil.dart';
import 'package:pixtrip/pages/create_trip.dart';
import 'package:pixtrip/pages/wallet.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Pixtrip',
    popGesture: false,
    defaultTransition: Transition.cupertino,
    locale: Locale('fr', 'FR'),
    fallbackLocale: Locale('fr', 'FR'),
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    translations: Messages(),
    home: App(),
  ));
}

class App extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  final Color _navBarItemActiveColor = Color(0xffd6bdfa);
  final Color _navBarItemAInactiveColor = Color(0xffd6bdfa);

  @override
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());

    return PersistentTabView(
      context,
      controller: _controller,
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).primaryColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
      screens: [Home(), Trips(), Profil(), CreateTrip(), Wallet()],
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: 'app__home'.tr,
          activeColorPrimary: _navBarItemActiveColor,
          inactiveColorPrimary: _navBarItemAInactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.place),
          title: 'app__trip'.tr,
          activeColorPrimary: _navBarItemActiveColor,
          inactiveColorPrimary: _navBarItemAInactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: 'app__profil'.tr,
          activeColorPrimary: _navBarItemActiveColor,
          inactiveColorPrimary: _navBarItemAInactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.add_location_alt),
          title: 'app__create_trip'.tr,
          activeColorPrimary: _navBarItemActiveColor,
          inactiveColorPrimary: _navBarItemAInactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.folder),
          title: 'app__wallet'.tr,
          activeColorPrimary: _navBarItemActiveColor,
          inactiveColorPrimary: _navBarItemAInactiveColor,
        ),
      ],
    );
  }
}
