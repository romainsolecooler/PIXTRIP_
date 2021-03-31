import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';

import 'package:pixtrip/components/trips/settings.dart';
import 'package:pixtrip/components/trips/trip.dart';

class Trips extends StatefulWidget {
  final String tripId;

  const Trips({
    Key key,
    this.tripId,
  }) : super(key: key);

  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.tripId != null) {
        Get.dialog(Trip(), barrierColor: Colors.transparent);
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
