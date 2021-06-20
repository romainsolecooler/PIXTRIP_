import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

class DistanceSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<Controller>(
      builder: (controller) {
        String label =
            'slider__distance_${controller.sliderDistance.value.toString()}'.tr;
        return Column(
          children: [
            Slider(
              onChanged: (value) => controller.setSliderDistance(value.toInt()),
              value: controller.sliderDistance.value.toDouble(),
              min: 0,
              max: 6,
              divisions: 6,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
