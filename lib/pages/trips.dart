import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';

import 'package:pixtrip/components/trips/settings.dart';
import 'package:pixtrip/components/trips/trip.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/travel/trip_details.dart';

class Trips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find();
    return Scaffold(
      appBar: appBar,
      //body: TripDetails(),
      body: Obx(() => c.finishedTrip.value ? TripDetails() : _AllTrips()),
    );
  }
}

class _AllTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
