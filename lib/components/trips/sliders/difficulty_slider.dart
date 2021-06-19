import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

class DifficultySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<Controller>(
      builder: (controller) {
        String label =
            'slider__difficulty_${controller.sliderDifficulty.value.toString()}'
                .tr;
        return Column(
          children: [
            Slider(
              onChanged: (value) =>
                  controller.setSliderDifficulty(value.toInt()),
              value: controller.sliderDifficulty.value.toDouble(),
              min: 0,
              max: 2,
              divisions: 2,
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
