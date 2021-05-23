import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/components/travel/compass_navigation_bar.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:rive/rive.dart';
import 'package:vector_math/vector_math.dart';

Controller c = Get.find();

class Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  Artboard _artboard;
  StateMachineController _controller;
  SMIInput<double> _levelInput;
  StreamSubscription<Position> _positionStream;

  double _latitude;
  double _longitude;
  int _distance;

  void setLevelInput() {
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
    if (rounded > -1) {
      _levelInput.value = rounded;
    }
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
    /* var timer = Timer.periodic(Duration(seconds: 5), (timer) {
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
      c.addPositionList({
        'lat': position.latitude,
        'lon': position.longitude,
      });
      int distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        c.tripLatitude.value,
        c.tripLongitude.value,
      ).round();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _distance = distance;
      });
      setLevelInput();
    });
  }

  @override
  void dispose() {
    _positionStream.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double compassSize = Get.width * 0.9;
    double factor = 0.7;

    return Scaffold(
      appBar: appBar,
      body: (_artboard != null &&
              _latitude != null &&
              _longitude != null &&
              _distance != null)
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      _distance > 10.0 ? '$_distance m' : '',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
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
                              fit: BoxFit.contain,
                            ),
                          ),
                          if (_distance > 10.0)
                            StreamBuilder<CompassEvent>(
                                stream: FlutterCompass.events,
                                builder: (context, snapshot) {
                                  //print('distance :');
                                  /* print(Geolocator.distanceBetween(_latitude, _longitude,
                          c.tripLatitude.value, c.tripLongitude.value)); */
                                  if (snapshot.connectionState !=
                                      ConnectionState.active) {
                                    return Text('connect');
                                  }
                                  if (snapshot.data.heading != null) {
                                    double heading = snapshot.data.heading;
                                    double bearing = Geolocator.bearingBetween(
                                        _latitude,
                                        _longitude,
                                        c.tripLatitude.value,
                                        c.tripLongitude.value);
                                    double rotation = (bearing - heading);
                                    //print('rotation : $rotation');
                                    //print('heading : $heading');
                                    //print('bearing : $bearing');
                                    return RotationTransition(
                                      turns: AlwaysStoppedAnimation(
                                          rotation / 360),
                                      child: Image.asset(
                                          'assets/animations/pointeur_cercle.png'),
                                    );
                                  }
                                  return CircularProgressIndicator.adaptive();
                                }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 10.0),
                      child: Text(
                        'travel__compass_text'.tr,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator.adaptive()),
      bottomNavigationBar: CompassNavigationBar(),
    );
  }
}

double getBearing(startLatitude, startLongitude, endLatitude, endLongitude) {
  double startLat = radians(startLatitude);
  double startLon = radians(startLongitude);
  double endLat = radians(endLatitude);
  double endLon = radians(endLongitude);

  double dLong = endLon - startLon;

  double dPhi =
      log(tan(endLat / 2.0 + pi / 4.0) / tan(startLat / 2.0 + pi / 4.0));

  if (dLong.abs() > pi) {
    if (dLong > 0.0) {
      dLong = -(2.0 * pi - dLong);
    } else {
      dLong = (2.0 * pi + dLong);
    }
  }
  double bearing = (degrees(atan2(dLong, dPhi)) + 360.0) % 360.0;
  return bearing;
}
