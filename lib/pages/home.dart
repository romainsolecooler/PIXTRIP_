import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/components/home/tutorial.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/tab_controller.dart';
import 'package:pixtrip/views/travel/compass.dart';

const EdgeInsets padding = EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0);

Controller c = Get.find();
MyTabController tabController = Get.find();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    print('init home state');
    if (c.finishedTrip.value) {
      Future.delayed(Duration.zero, () {
        //c.goToPageWithoutTransition(index: 1, resetFinishedTrip: false);
        tabController.to(index: 1, resetFinishedTrip: false);
      });
    }
    if (c.tutorialStep.value == 0) {
      Future.delayed(Duration.zero, () {
        Get.dialog(
          Tutorial(),
          barrierColor: Colors.transparent,
          barrierDismissible: false,
        );
      });
    }
    if (c.homeTrips.length == 0) {
      getHomeTrips();
    }
  }

  void getHomeTrips() async {
    setState(() => _loading = true);
    var response = await dio.post('trip/get_home_trips.php');
    logger.d(response.data);
    c.setHomeTrips(response.data);
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (final item in c.homeTrips) {
      children.add(HomeTrip(
        element: item,
      ));
    }

    Widget hometrips = _loading
        ? Center(child: CircularProgressIndicator.adaptive())
        : Column(children: children);

    return Column(
      children: [
        Flexible(
          flex: 2,
          child: hometrips,
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              _PageDivider(),
              _ChooseTrip(),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class HomeTrip extends StatelessWidget {
  final Map<String, dynamic> element;

  const HomeTrip({Key key, this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 8.0),
        child: InkWell(
          onTap: () {
            c.setTripSelectedFromHome(true);
            c.setTrip(element);
            //c.goToPage(index: 1);
            tabController.to(index: 1);
          },
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    child: LoadImageWithLoader(
                      url: 'trips/${element['image']}',
                      blurred: true,
                      fromAdmin: element['from_admin'],
                    ),
                    padding: padding,
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        element['city'],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PageDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Flexible(
          flex: 1,
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Text('home__or'.tr),
        ),
        Flexible(
          flex: 1,
          child: Divider(),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}

class _ChooseTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: InkWell(
          onTap: () => tabController.to(index: 1),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 45,
                  child: Padding(
                    padding: padding,
                    child: Image.asset(
                      'assets/images/tutorial/2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 55,
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'home__choose_trip_title'.tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'home__choose_trip_text'.tr,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
