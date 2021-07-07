import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixtrip/components/travel/give_up_popup.dart';
import 'package:pixtrip/controllers/compass_controller.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/travel/fail.dart';
import 'package:pixtrip/views/travel/success.dart';

import 'package:camerawesome/camerapreview.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/models/capture_modes.dart';
import 'package:camerawesome/models/sensors.dart';

Controller c = Get.find();
Color color = Colors.white;

class GiveUpTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () => Get.dialog(
          GiveUpPopup(),
          barrierColor: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.close,
              color: color,
            ),
            Text(
              'travel__give_up_trip'.tr,
              style: TextStyle(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoScreen extends GetView<CompassController> {
  void takePhoto() async {
    Get.back();
    if (controller.distance() < 20 && controller.loadedDistance()) {
      Get.offAll(() => Success());
    } else {
      Get.to(() => Fail());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          CameraAwesome(
            testMode: false,
            sensor: ValueNotifier(Sensors.BACK),
            photoSize: ValueNotifier(null),
            captureMode: ValueNotifier(CaptureModes.PHOTO),
            orientation: DeviceOrientation.portraitUp,
            fitted: false,
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
            ),
            child: IconButton(
              onPressed: Get.back,
              icon: Icon(Icons.close),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takePhoto,
        child: Icon(Icons.photo_camera),
        tooltip: 'travel__take_photo'.tr,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class TakePhoto extends GetView<CompassController> {
  void _takePhoto() async {
    Get.dialog(PhotoScreen(), barrierColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: _takePhoto,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.camera_alt,
              color: color,
            ),
            Text(
              'travel__take_photo'.tr,
              style: TextStyle(
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
