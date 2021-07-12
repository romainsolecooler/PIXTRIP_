import 'package:flutter/material.dart';
import 'package:pixtrip/common/app_bar.dart';

import 'package:pixtrip/components/add_trip/add_photo.dart';
import 'package:pixtrip/components/add_trip/category.dart';
import 'package:pixtrip/components/add_trip/textfields.dart';
import 'package:pixtrip/components/add_trip/position.dart';
import 'package:pixtrip/components/add_trip/buttons.dart';
import 'package:pixtrip/components/add_trip/sliders/sliders.dart';
import 'package:pixtrip/components/add_trip/type.dart';

class CreateTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            AddPhoto(),
            SizedBox(height: 35),
            CityName(),
            SizedBox(height: 25),
            //AddPosition(),
            SizedBox(height: 25),
            ChooseType(),
            SizedBox(height: 15.0),
            Category(),
            SizedBox(height: 15.0),
            DifficultySlider(),
            _CustomDivider(),
            FirstInfo(),
            SizedBox(height: 25),
            SecondInfo(),
            SizedBox(height: 25),
            ThirdInfo(),
            SizedBox(height: 30),
            AddTripButton(),
          ],
        ),
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  final double _indent = 25;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: _indent,
      endIndent: _indent,
      height: 50,
    );
  }
}
