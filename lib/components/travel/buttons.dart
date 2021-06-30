import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixtrip/components/travel/give_up_popup.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/travel/fail.dart';
import 'package:pixtrip/views/travel/photo_check.dart';
import 'package:pixtrip/views/travel/success.dart';

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

class TakePhoto extends StatelessWidget {
  final picker = ImagePicker();

  void _takePhoto() async {
    print('taking photo bg');
    c.setPhotoPath('');
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      print('getting distance --------');
      double distance = Geolocator.distanceBetween(
          c.currentUserLatitude.value,
          c.currentUserLongitude.value,
          c.tripLatitude.value,
          c.tripLongitude.value);
      if (distance < 20.0) {
        c.setPhotoPath(pickedFile.path);
        Get.offAll(() => Success());
      } else {
        Get.to(() => Fail());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          print('gonna take photo');
          _takePhoto();
        },
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
