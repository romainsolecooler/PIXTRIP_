import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';

import 'package:pixtrip/components/trips/settings.dart';
import 'package:pixtrip/components/trips/trip.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class Trips extends StatefulWidget {
  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (c.tripSelectedFromHome.value) {
        Get.dialog(Trip(), barrierColor: Colors.transparent);
        c.setTripSelectedFromHome(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: IconButton(
                icon: Icon(CupertinoIcons.slider_horizontal_3),
                onPressed: () => Get.dialog(
                  TripsSettings(),
                  barrierColor: Colors.transparent,
                ),
              ),
            ),
            Expanded(child: TripsList()),
          ],
        ),
      ),
    );
  }
}
