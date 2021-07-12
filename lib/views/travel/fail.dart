import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/components/travel/compass_navigation_bar.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class Fail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('travel__fail_title'.tr),
            SizedBox(height: 20.0),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: LoadImageWithLoader(
                url: 'trips/' + c.tripImage(),
                blurred: true,
              ),
            ),
            SizedBox(height: 25.0),
            Text('travel__fail_text'.tr),
            SizedBox(height: 25.0),
            _ContinueTripButton(),
          ],
        ),
      ),
      bottomNavigationBar: CompassNavigationBar(),
    );
  }
}

class _ContinueTripButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.back(),
      child: Text('travel__fail_continue_trip'.tr),
    );
  }
}
