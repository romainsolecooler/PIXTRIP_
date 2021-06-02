import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Zone extends StatefulWidget {
  final double size;

  const Zone({Key key, this.size}) : super(key: key);

  @override
  _ZoneState createState() => _ZoneState();
}

class _ZoneState extends State<Zone> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller
          ..reset()
          ..forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
          //shape: BoxShape.circle,
          //color: Colors.red,
          ),
      child: Lottie.asset(
        'assets/animations/zone.json',
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration * 2
            ..forward();
        },
      ),
    );
  }
}
