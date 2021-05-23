import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/components/travel/compass_navigation_bar.dart';
import 'package:pixtrip/components/travel/photo.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';

Controller c = Get.find();

class Success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 2000), () {
      c.setFinishedTrip(true);
      Get.offAll(() => App());
    });
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
              child: Column(
                children: [
                  Photo(opacity: true),
                  SizedBox(height: 50.0),
                  Text('travel__sucess_title'.tr),
                  SizedBox(height: 10.0),
                  Text('travel__sucess_text'.tr),
                ],
              ),
            ),
            LottieBuilder.asset(
              'assets/animations/celebration.json',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
