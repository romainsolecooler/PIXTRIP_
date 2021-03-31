import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

class DifficultySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<Controller>(
      builder: (controller) {
        String label =
            'slider__difficulty_${controller.addDifficulty.value.toString()}'
                .tr;
        return Column(
          children: [
            Slider(
              onChanged: (value) => controller.setAddDifficulty(value.toInt()),
              value: controller.addDifficulty.value.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              activeColor: Theme.of(context).primaryColor,
            ),
            Text(label),
          ],
        );
      },
    );
  }
}
