import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:pixtrip/common/app_bar.dart';

import 'package:pixtrip/pages/trips.dart';

const EdgeInsets padding = EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                _HomeTrip(
                  image: 'https://picsum.photos/50?image=1',
                  title: 'Saint-Cyprien',
                ),
                _HomeTrip(
                  image: 'https://picsum.photos/50?image=2',
                  title: 'Sainte-Marie',
                ),
                _HomeTrip(
                  image: 'https://picsum.photos/50?image=3',
                  title: 'Canet en Roussillon',
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                _PageDivider(),
                _ChooseTrip(),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeTrip extends StatelessWidget {
  final String image;
  final String title;

  const _HomeTrip({Key key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 8.0),
        child: InkWell(
          onTap: () => pushNewScreen(context, screen: Trips(tripId: 'toto')),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    child: Placeholder(),
                    padding: padding,
                    /* child: Image.network(
                      image,
                    ), */
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
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
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
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
        margin: EdgeInsets.only(top: 8.0),
        child: InkWell(
          onTap: () => pushNewScreen(context, screen: Trips()),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    child: Placeholder(),
                    padding: padding,
                    /* child: Image.network(
                      image,
                    ), */
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 1,
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
                          color: Colors.grey,
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
