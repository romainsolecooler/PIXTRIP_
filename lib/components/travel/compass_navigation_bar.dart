import 'package:flutter/material.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/components/travel/buttons.dart';

class CompassNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkBlueColor[900],
      child: SafeArea(
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TakePhoto(),
              GiveUpTrip(),
            ],
          ),
        ),
      ),
    );
  }
}
