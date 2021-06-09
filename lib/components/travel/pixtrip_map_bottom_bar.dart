import 'package:flutter/material.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/components/travel/buttons.dart';

class PixtripMapBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kBottomNavigationBarHeight,
        color: darkBlueColor[900],
        child: Row(
          children: [
            GiveUpTrip(),
          ],
        ),
      ),
    );
  }
}