import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:rive/rive.dart';
import 'package:wakelock/wakelock.dart';

Controller c = Get.find();

class CompassController extends GetxController {
  final loadedArtboard = false.obs;
  final showCompass = false.obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final distance = 0.obs;
  final loadedDistance = false.obs;

  final compassAnimation = CompassAnimation().obs;
  StreamSubscription<Position> positionStream;

  @override
  void onInit() {
    super.onInit();
    Wakelock.enable();
    rootBundle
        .load('assets/animations/boussole_pixtrip2.riv')
        .then((data) async {
      final file = RiveFile.import(data);

      final _artboard = file.mainArtboard;
      var controller =
          StateMachineController.fromArtboard(_artboard, 'State Machine 1');
      if (controller != null) {
        _artboard.addController(controller);
        compassAnimation.update((compassAnimation) {
          compassAnimation.levelInput = controller.findInput('Number 1');
        });
        //levelInput = controller.findInput('Number 1');
        //_levelInput.value = 3.0;
      }
      compassAnimation.update((compassAnimation) {
        compassAnimation.artboard = _artboard;
      });
      //artboard = _artboard;
    });
    positionStream = Geolocator.getPositionStream().listen((position) {
      c.addPositionList({
        'lat': position.latitude,
        'lon': position.longitude,
      });
      int _distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        c.tripLatitude.value,
        c.tripLongitude.value,
      ).round();
      latitude(position.latitude);
      longitude(position.longitude);
      distance(_distance);
      setLevelInput();
      loadedArtboard(true);
      loadedDistance(true);
      showCompass(distance > 20 ? true : false);
    });
  }

  @override
  void onClose() {
    super.onClose();
    print('canceled compass stream');
    Wakelock.disable();
    positionStream.cancel();
    super.dispose();
  }

  void setLevelInput() {
    double remainingDistance = distance().toDouble();
    double tripDistance = c.tripEnvironment.value == 'urban'
        ? 1000.0
        : 2500.0; // trip distance in meters
    double doneDistance = tripDistance - remainingDistance;
    double doneDistanceInPercentage = (doneDistance / tripDistance) * 100;
    double rounded = (doneDistanceInPercentage / 10).round().toDouble();
    print('rounded : $rounded');
    if (rounded > -1) {
      compassAnimation.update((el) {
        el.levelInput.value = rounded;
      });
    } else {
      compassAnimation.update((el) {
        el.levelInput.value = 0.0;
      });
    }
  }
}

class CompassAnimation {
  Artboard artboard;
  SMIInput<double> levelInput;
  CompassAnimation({Artboard artboard, SMIInput<double> levelInput});
}
