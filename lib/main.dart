import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/bottom_navigation_bar.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/common/messages.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/login_controller.dart';
import 'package:pixtrip/controllers/tab_controller.dart';

import 'package:pixtrip/pages/home.dart';
import 'package:pixtrip/pages/trips.dart';
import 'package:pixtrip/pages/profil.dart';
import 'package:pixtrip/pages/add_trip.dart';
import 'package:pixtrip/pages/wallet.dart';
import 'package:pixtrip/pages/permissions.dart';

import 'package:pixtrip/not_logged/login/login.dart';

Controller c = Get.put(Controller());

void main() async {
  await GetStorage.init();
  final box = GetStorage();
  String user = box.read('user');
  Widget homeWidget;
  c.fetch.baseUrl = 'https://pixtrip.fr/api/';
  c.fetch.defaultContentType = 'application/json';
  if (user != null) {
    var response = await dio.post('user/get_user.php', data: {'u_id': user});
    var data = response.data;
    homeWidget = App();
    c.setUserId(user);
    c.setUserMail(data['email']);
    c.setUserPseudo(data['pseudo']);
    c.setUserImage(data['image']);
    c.setUserAge(data['age']);
    c.setTutorialStep(data['tutorial']);
  } else {
    Get.put(LoginController());
    homeWidget = Login();
  }
  // c.fetch.defaultDecoder = (data) => jsonDecode(data);
  WidgetsFlutterBinding.ensureInitialized();
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      title: 'Pixtrip',
      popGesture: false,
      defaultTransition: Transition.cupertino,
      locale: Locale('fr', 'FR'),
      fallbackLocale: Locale('fr', 'FR'),
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        primarySwatch: MaterialColor(0xff1243a6, blueColor),
        inputDecorationTheme: inputDecorationTheme,
        sliderTheme: SliderThemeData(
          thumbColor: redColor[900],
          activeTrackColor: redColor[900],
          inactiveTrackColor: redColor[400],
          inactiveTickMarkColor: redColor[900],
          activeTickMarkColor: Colors.white,
          overlayColor: redColor[100],
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: materialStateColorRed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
            backgroundColor: materialStateColorRed,
          ),
        ),
      ),
      translations: Messages(),
      home: homeWidget,
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final controller = PageController(
    initialPage: 1,
  );

  MyTabController tabController = Get.put(MyTabController(), permanent: true);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkPermissions(
        success: () => null,
        callBack: () => Get.offAll(Permissions()),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Tooltip> _buildBottomItems() {
    Map<String, IconData> tabIcons = {
      'app__home': Icons.home,
      'app__trip': Icons.place,
      'app__profil': Icons.person,
      'app__create_trip': Icons.add_location_alt,
      'app__wallet': Icons.folder
    };

    List<Tooltip> items = [];
    tabIcons.forEach((key, el) {
      items.add(
        Tooltip(
          message: key.tr,
          child: Tab(
            icon: Icon(
              el,
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ),
      );
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: WillPopScope(
        onWillPop: () async {
          if (tabController.tabController.index > 0) {
            tabController.to(index: 0);
            return false;
          }
          return true;
        },
        child: TabBarView(
          controller: tabController.tabController,
          children: [
            Home(),
            Trips(),
            Profil(),
            CreateTrip(),
            Wallet(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: tabController.tabController,
          labelColor: Theme.of(context).textTheme.bodyText1.color,
          onTap: (_) {
            c.setFinishedTrip(false);
          },
          tabs: _buildBottomItems(),
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: WillPopScope(
        onWillPop: () async {
          print(c.currentIndex.value);
          if (c.currentIndex.value > 0) {
            c.goToPage(index: 0);
            return false;
          }
          return true;
        },
        child: PageView(
          controller: c.tabBarController.value,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Home(),
            Trips(),
            Profil(),
            CreateTrip(),
            Wallet(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
