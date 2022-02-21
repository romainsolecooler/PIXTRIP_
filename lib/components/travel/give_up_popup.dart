import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

import 'package:pixtrip/main.dart';
import 'package:wakelock/wakelock.dart';

Controller c = Get.find();

class GiveUpPopup extends StatelessWidget {
  void _giveUpTrip(BuildContext context) {
    Wakelock.disable();
    Get.offAll(() => App());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          padding: EdgeInsets.all(25.0),
          width: Get.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'travel__popup_give_up_trip_title'.tr,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () => _giveUpTrip(context),
                child: Text('travel__popup_give_up_trip_button'.tr),
              )
            ],
          ),
        ),
      ),
    );
  }
}
