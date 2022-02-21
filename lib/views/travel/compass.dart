import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/components/travel/compass_navigation_bar.dart';
import 'package:pixtrip/components/travel/give_up_popup.dart';
import 'package:pixtrip/controllers/compass_controller.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:rive/rive.dart';

Controller c = Get.find();

List<int> data = [0];
double rotate = 0;

class Compass extends GetView<CompassController> {
  Compass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuilt parent');
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(
          GiveUpPopup(),
          barrierColor: Colors.transparent,
        );
        return false;
      },
      child: Scaffold(
        appBar: appBar,
        body: Obx(
          () {
            logger.i(controller.loadedArtboard());
            return controller.loadedArtboard()
                ? LoadedCompass()
                : Center(child: CircularProgressIndicator.adaptive());
          },
        ),
        bottomNavigationBar: CompassNavigationBar(),
      ),
    );
  }
}

class LoadedCompass extends GetView<CompassController> {
  LoadedCompass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double compassSize = Get.width * 0.9;
    double factor = 0.7;

    logger.wtf('rebuild tototoo');

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Text(
                controller.distance() > 100 ? '${controller.distance()} m' : '',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: compassSize,
              height: compassSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(
                    () => FractionallySizedBox(
                      widthFactor: factor,
                      heightFactor: factor,
                      child: Rive(
                        artboard: controller.compassAnimation().artboard,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Obx(() => AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        opacity: controller.showCompass() ? 1 : 0,
                        child: StreamBuilder<CompassEvent>(
                            stream: FlutterCompass.events,
                            builder: (context, snapshot) {
                              //logger.d(snapshot.data);
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              }
                              if (snapshot.data.heading != null) {
                                double heading = snapshot.data.heading + 180;
                                double bearing = Geolocator.bearingBetween(
                                    controller.latitude(),
                                    controller.longitude(),
                                    c.tripLatitude.value,
                                    c.tripLongitude.value);
                                int rotation = (bearing - heading).round();
                                rotation = rotation % 360;
                                //print('rotation : $rotation');
                                //data.add(rotation);
                                //data.removeAt(0);
                                //int previous = data.last;
                                int dur =
                                    rotation < 30 || rotation > 330 ? 0 : 75;
                                double rot = rotation * pi / 180;
                                /* return RotationTransition(
                                  turns: AlwaysStoppedAnimation(rotation / 360),
                                  child: Image.asset(
                                      'assets/animations/pointeur_cercle.png'),
                                ); */
                                return TweenAnimationBuilder(
                                  duration: Duration(milliseconds: dur),
                                  tween: Tween<double>(begin: 0, end: rot),
                                  builder: (_, angle, __) {
                                    return Transform.rotate(
                                      angle: angle + pi,
                                      child: Image.asset(
                                        'assets/animations/pointeur_cercle.png',
                                      ),
                                    );
                                  },
                                );
                              }
                              return CircularProgressIndicator.adaptive();
                            }),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child: Text(
                'travel__compass_text'.tr,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<_Compass>
    with SingleTickerProviderStateMixin {
  Artboard _artboard;
  // StateMachineController _controller;
  SMIInput<double> _levelInput;
  StreamSubscription<Position> _positionStream;

  double _latitude;
  double _longitude;
  int _distance;

  void setLevelInput() {
    double remainingDistance = Geolocator.distanceBetween(
        _latitude, _longitude, c.tripLatitude.value, c.tripLongitude.value);
    double tripDistance = c.tripEnvironment.value == 'urban'
        ? 1000.0
        : 2500.0; // trip distance in meters
    double doneDistance = tripDistance - remainingDistance;
    double doneDistanceInPercentage =
        ((doneDistance - remainingDistance) * 100) /
            (tripDistance - remainingDistance);
    double rounded = (doneDistanceInPercentage / 10).round().toDouble();
    print('rounded : $rounded');
    if (rounded > -1) {
      _levelInput.value = rounded;
    } else {
      _levelInput.value = 0.0;
    }
  }

  double normalize(double angle) {
    return (angle >= 0 ? angle : (360 - ((-angle) % 360))) % 360;
  }

  @override
  void initState() {
    super.initState();
    rootBundle
        .load('assets/animations/boussole_pixtrip2.riv')
        .then((data) async {
      final file = RiveFile.import(data);

      final artboard = file.mainArtboard;
      var controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
      if (controller != null) {
        artboard.addController(controller);
        _levelInput = controller.findInput('Number 1');
        //_levelInput.value = 3.0;
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
    print('canceled compass stream');
    _positionStream.cancel();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double compassSize = Get.width * 0.9;
    double factor = 0.7;

    logger.wtf('rebiuld');

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
                      _distance > 10 ? '$_distance m' : '',
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
                          if (_distance > 20)
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
                                    int rotation = (bearing - heading).round();
                                    //print('bearing $bearing');
                                    //print('heading $heading');
                                    rotation = rotation % 360;
                                    rotation = (rotation / 10).round() * 10;
                                    logger.d('rotation : $rotation');
                                    double rot = rotation * pi / 180;
                                    int previous = data.last;
                                    double difference = rot - previous;
                                    rotate += difference;
                                    //print(rotate);
                                    /* print('good $rot');
                                    print('previous : $previous');
                                    print(previous - rot); */
                                    //print('rotate $rotate');
                                    //int timing = 60;
                                    //print('heading : $heading');
                                    //print('bearing : $bearing');
                                    /* return AnimatedContainer(
                                      width: compassSize,
                                      height: compassSize,
                                      duration: Duration(milliseconds: timing),
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..translate(
                                            compassSize / 2, compassSize / 2, 0)
                                        //..rotateZ(_rot * pi / 180)
                                        ..rotateZ(rot)
                                        ..translate(-compassSize / 2,
                                            -compassSize / 2, 0),
                                      child: Image.asset(
                                          'assets/animations/pointeur_cercle.png'),
                                    ); */
                                    return TweenAnimationBuilder(
                                      duration: const Duration(
                                        milliseconds: 75,
                                      ),
                                      tween: Tween<double>(begin: 0, end: rot),
                                      builder: (_, angle, __) {
                                        return Transform.rotate(
                                          angle: angle,
                                          child: Image.asset(
                                            'assets/animations/pointeur_cercle.png',
                                          ),
                                        );
                                      },
                                    );
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
