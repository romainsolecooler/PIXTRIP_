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

import 'package:pixtrip/not_logged/login/login.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();
  Map<String, dynamic> user = box.read('user');
  Widget homeWidget;
  Controller c = Get.put(Controller());
  c.fetch.baseUrl = 'https://pixtrip.fr/api/';
  c.fetch.defaultContentType = 'application/json';
  if (user != null) {
    homeWidget = App();
    c.setUserId(user['u_id']);
    c.setUserMail(user['email']);
    c.setUserPseudo(user['pseudo']);
  } else {
    homeWidget = Login();
  }
  // c.fetch.defaultDecoder = (data) => jsonDecode(data);
  runApp(Pixtrip(homeWidget: homeWidget));
}

class Pixtrip extends StatelessWidget {
  const Pixtrip({
    Key key,
    @required this.homeWidget,
  }) : super(key: key);

  final Widget homeWidget;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(20.0),
    );

    InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      focusedBorder: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 22.0,
      ),
    );

    return GetMaterialApp(
      title: 'Pixtrip',
      popGesture: false,
      defaultTransition: Transition.cupertino,
      locale: Locale('fr', 'FR'),
      fallbackLocale: Locale('fr', 'FR'),
      theme: ThemeData(
        textTheme: GoogleFonts.comfortaaTextTheme(),
        primarySwatch: MaterialColor(0xff1243a6, blueColor),
        inputDecorationTheme: inputDecorationTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
          ),
        ),
      ),
      translations: Messages(),
      home: homeWidget,
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color _navBarItemActiveColor =
        Theme.of(context).textTheme.bodyText1.color;
    final Color _navBarItemAInactiveColor =
        Theme.of(context).textTheme.bodyText1.color;

    Controller c = Get.find();

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
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
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
