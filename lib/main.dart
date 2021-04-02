import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/common/messages.dart';
import 'package:pixtrip/common/custom_colors.dart';

import 'package:pixtrip/pages/home.dart';
import 'package:pixtrip/pages/trips.dart';
import 'package:pixtrip/pages/profil.dart';
import 'package:pixtrip/pages/add_trip.dart';
import 'package:pixtrip/pages/wallet.dart';

import 'package:pixtrip/login.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();
  Widget homeWidget = box.read('user') != null ? App() : Login();
  homeWidget = App();
  runApp(GetMaterialApp(
    title: 'Pixtrip',
    popGesture: false,
    defaultTransition: Transition.cupertino,
    locale: Locale('fr', 'FR'),
    fallbackLocale: Locale('fr', 'FR'),
    theme: ThemeData(
      textTheme: GoogleFonts.comfortaaTextTheme(),
      primarySwatch: MaterialColor(0xff1243a6, blueColor),
    ),
    translations: Messages(),
    home: homeWidget,
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color _navBarItemActiveColor =
        Theme.of(context).textTheme.bodyText1.color;
    final Color _navBarItemAInactiveColor =
        Theme.of(context).textTheme.bodyText1.color;

    Controller c = Get.put(Controller());

    return PersistentTabView(
      context,
      controller: c.appBarController.value,
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
