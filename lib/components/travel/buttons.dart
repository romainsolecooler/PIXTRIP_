import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
        onPressed: () =>
            Get.dialog(GiveUpPopup(), barrierColor: Colors.transparent),
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
  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);
  ValueNotifier<Size> _photoSize = ValueNotifier(null);

  // Controllers
  PictureController _pictureController = new PictureController();
  VideoController _videoController = new VideoController();

  void takePhoto() async {
    final Directory extDir = await getTemporaryDirectory();
    final testDir =
        await Directory('${extDir.path}/test').create(recursive: true);
    final String filePath =
        '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    await _pictureController.takePicture(filePath);
    if (controller.distance() < 20 && controller.loadedDistance()) {
      c.photoPath(filePath);
      Get.offAll(() => Success());
    } else {
      Get.off(() => Fail());
    }
  }

  Future<void> load() async {
    await Future.delayed(Duration(milliseconds: 300));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return Stack(
              alignment: Alignment.topRight,
              children: [
                CameraAwesome(
                  testMode: false,
                  selectDefaultSize: (List<Size> availableSizes) =>
                      Size(1920, 1080),
                  sensor: _sensor,
                  photoSize: _photoSize,
                  switchFlashMode: _switchFlash,
                  captureMode: _captureMode,
                  orientation: DeviceOrientation.portraitUp,
                  fitted: false,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.7),
                  ),
                  child: IconButton(
                    onPressed: Get.back,
                    icon: Icon(Icons.close),
                  ),
                )
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: takePhoto,
          child: Icon(Icons.photo_camera),
          tooltip: 'travel__take_photo'.tr,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class TakePhoto extends GetView<CompassController> {
  void _takePhoto() async {
    Get.to(
      () => PhotoScreen(),
      transition: Transition.size,
      fullscreenDialog: true,
    );
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
