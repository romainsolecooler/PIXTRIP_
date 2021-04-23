import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

class TimeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<Controller>(
      builder: (controller) {
        String label = 'slider__time_${controller.addTime.value.toString()}'.tr;
        return Column(
          children: [
            Slider(
              onChanged: (value) => controller.setAddTime(value.toInt()),
              value: controller.addTime.value.toDouble(),
              min: 0,
              max: 3,
              divisions: 3,
            ),
            Text(label),
          ],
        );
      },
    );
  }
}
