import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class TutorialCompass extends StatefulWidget {
  const TutorialCompass({Key key}) : super(key: key);

  @override
  _TutorialCompassState createState() => _TutorialCompassState();
}

class _TutorialCompassState extends State<TutorialCompass>
    with SingleTickerProviderStateMixin {
  Artboard _artboard;
  RiveAnimationController _controller;
  SMIInput<double> _levelInput;
  Timer _timer;
  double _animationRotation = 0.0;
  Timer _animationTimer;

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
        _levelInput.value = 1.0;
      }
      setState(() {
        _artboard = artboard;
      });
    });
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_levelInput.value < 10) {
        _levelInput.value++;
      } else {
        _timer.cancel();
      }
    });
    setRandomRotation();
    _animationTimer = Timer.periodic(Duration(seconds: 4), (_) {
      setRandomRotation();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationTimer.cancel();
    super.dispose();
  }

  void setRandomRotation() {
    setState(() => _animationRotation = Random().nextDouble() * (2 * pi));
  }

  @override
  Widget build(BuildContext context) {
    return _artboard != null
        ? Stack(
            alignment: Alignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.7,
                heightFactor: 0.7,
                child: Rive(
                  artboard: _artboard,
                  fit: BoxFit.contain,
                ),
              ),
              TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                curve: Curves.bounceOut,
                tween: Tween<double>(begin: 0, end: _animationRotation),
                builder: (_, angle, __) {
                  return Transform.rotate(
                    angle: angle,
                    child: Image.asset(
                      'assets/animations/pointeur_cercle.png',
                    ),
                  );
                },
              ),
            ],
          )
        : Container();
  }
}
