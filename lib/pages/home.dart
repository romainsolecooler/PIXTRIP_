import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/components/home/tutorial.dart';
import 'package:pixtrip/controllers/controller.dart';

const EdgeInsets padding = EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      return;
      Get.dialog(
        Tutorial(),
        barrierColor: Colors.transparent,
        barrierDismissible: false,
      );
    });
  }

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
                  image: 'https://source.unsplash.com/random',
                  title: 'Saint-Cyprien',
                ),
                _HomeTrip(
                  image: 'https://source.unsplash.com/random',
                  title: 'Sainte-Marie',
                ),
                _HomeTrip(
                  image: 'https://source.unsplash.com/random',
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
    Controller c = Get.find();

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 8.0),
        child: InkWell(
          onTap: () {
            c.setAppBarController(1);
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
                      url: image,
                      blurred: true,
                    ),
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
    Controller c = Get.find();

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 8.0),
        child: InkWell(
          onTap: () {
            c.setAppBarController(1);
          },
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: padding,
                    child: LoadAssetsImage(
                      source: 'assets/images/google_maps.jpg',
                    ),
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
