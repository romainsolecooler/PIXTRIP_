import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/settings_controller.dart';

class DistanceSlider extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String label =
          'slider__distance_${controller.distanceSlider().toString()}'.tr;
      return Column(
        children: [
          Slider(
            onChanged: (value) => controller.distanceSlider(value.toInt()),
            value: controller.distanceSlider().toDouble(),
            min: 0,
            max: 4,
            divisions: 4,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
          ),
        ],
      );
    });
  }
}
