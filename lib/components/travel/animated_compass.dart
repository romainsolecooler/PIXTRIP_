import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/travel/compass.dart';
import 'package:rive/rive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:sensors/sensors.dart';

Controller c = Get.find();

class AnimatedCompass extends StatefulWidget {
  @override
  _AnimatedCompassState createState() => _AnimatedCompassState();
}

class _AnimatedCompassState extends State<AnimatedCompass> {
  Artboard _artboard;
  StateMachineController _controller;
  SMIInput<double> _levelInput;
  StreamSubscription<Position> _positionStream;

  double _latitude;
  double _longitude;

  void getLevelInput() {
    double remainingDistance = Geolocator.distanceBetween(
        _latitude, _longitude, c.tripLatitude.value, c.tripLongitude.value);
    double tripDistance = ((c.tripDistance.value + 1) * 1000)
        .toDouble(); // trip distance in meters
    double doneDistance = tripDistance - remainingDistance;
    double doneDistanceInPercentage =
        ((doneDistance - remainingDistance) * 100) /
            (tripDistance - remainingDistance);
    double rounded = (doneDistanceInPercentage / 10).round().toDouble();
    print('rounded : $rounded');
    _levelInput.value = rounded;
  }

  @override
  void initState() {
    super.initState();
    rootBundle
        .load('assets/animations/boussole_pixtrip.riv')
        .then((data) async {
      final file = RiveFile.import(data);

      final artboard = file.mainArtboard;
      var controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
      if (controller != null) {
        artboard.addController(controller);
        _levelInput = controller.findInput('Number 1');
        _levelInput.value = 0.0;
      }
      setState(() {
        _artboard = artboard;
      });
    });
    /* var timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_levelInput.value < 10) {
        _levelInput.value++;
      }
    }); */
    _positionStream = Geolocator.getPositionStream().listen((position) {
      c.setCurrentUserposition(
        position.latitude,
        position.longitude,
        position.altitude,
      );
      print('totototototo');
      print(Geolocator.bearingBetween(
        position.latitude,
        position.longitude,
        c.tripLatitude.value,
        c.tripLongitude.value,
      ));
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
      getLevelInput();
    });
  }

  @override
  void dispose() {
    print('dispose');
    _positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double compassSize = Get.width * 0.9;
    double factor = 0.7;

    print(_latitude);
    print(_longitude);

    return (_artboard == null && _latitude != null && _longitude != null)
        ? CircularProgressIndicator.adaptive()
        : Container(
            width: compassSize,
            height: compassSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                FractionallySizedBox(
                  widthFactor: factor,
                  heightFactor: factor,
                  child: Rive(
                    artboard: _artboard,
                    fit: BoxFit.cover,
                  ),
                ),
                StreamBuilder<CompassEvent>(
                    stream: FlutterCompass.events,
                    builder: (context, snapshot) {
                      //print('distance :');
                      /* print(Geolocator.distanceBetween(_latitude, _longitude,
                          c.tripLatitude.value, c.tripLongitude.value)); */
                      return RotationTransition(
                        turns: AlwaysStoppedAnimation((getOffsetFromNorth(
                                    _latitude,
                                    _longitude,
                                    c.tripLatitude.value,
                                    c.tripLongitude.value) +
                                snapshot.data.heading) /
                            360),
                        child: SvgPicture.asset(
                            'assets/animations/pointeur_cercle.svg'),
                      );
                    })
              ],
            ),
          );
  }
}

class _Compass extends StatelessWidget {
  final double latitude;
  final double longitude;

  const _Compass({
    Key key,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          //print('distance :');
          /* print(Geolocator.distanceBetween(_latitude, _longitude,
                          c.tripLatitude.value, c.tripLongitude.value)); */
          return RotationTransition(
            turns: AlwaysStoppedAnimation((getOffsetFromNorth(
                        latitude,
                        longitude,
                        c.tripLatitude.value,
                        c.tripLongitude.value) -
                    snapshot.data.heading) /
                360),
            child: SvgPicture.asset('assets/animations/pointeur_cercle.svg'),
          );
        });
  }
}

double getOffsetFromNorth(double currentLatitude, double currentLongitude,
    double targetLatitude, double targetLongitude) {
  var la_rad = radians(currentLatitude);
  var lo_rad = radians(currentLongitude);

  var de_la = radians(targetLatitude);
  var de_lo = radians(targetLongitude);

  var toDegrees = degrees(atan(sin(de_lo - lo_rad) /
      ((cos(la_rad) * tan(de_la)) - (sin(la_rad) * cos(de_lo - lo_rad)))));
  if (la_rad > de_la) {
    if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
        toDegrees > 0.0 &&
        toDegrees <= 90.0) {
      toDegrees += 180.0;
    } else if (lo_rad <= de_lo &&
        lo_rad >= radians(-180.0) + de_lo &&
        toDegrees > -90.0 &&
        toDegrees < 0.0) {
      toDegrees += 180.0;
    }
  }
  if (la_rad < de_la) {
    if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
        toDegrees > 0.0 &&
        toDegrees < 90.0) {
      toDegrees += 180.0;
    }
    if (lo_rad <= de_lo &&
        lo_rad >= radians(-180.0) + de_lo &&
        toDegrees > -90.0 &&
        toDegrees <= 0.0) {
      toDegrees += 180.0;
    }
  }
  return toDegrees;
}
