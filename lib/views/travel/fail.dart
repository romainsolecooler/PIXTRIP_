import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/components/travel/compass_navigation_bar.dart';

class Fail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('travel__fail_title'.tr),
            SizedBox(height: 150.0),
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
