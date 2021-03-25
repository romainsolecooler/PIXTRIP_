import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

class DistanceSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<Controller>(
      builder: (controller) {
        return Column(
          children: [
            Slider(
              onChanged: (value) => controller.setSliderDistance(value),
              value: controller.sliderDistance.value,
              min: 1,
              max: 5,
              divisions: 4,
              activeColor: Theme.of(context).primaryColor,
            ),
            Text('slider__distance_label'.trParams({
              'distance': controller.sliderDistance.value.toInt().toString()
            }))
          ],
        );
      },
    );
  }
}
