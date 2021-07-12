import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/settings_controller.dart';

/* class DifficultySlider extends StatelessWidget {
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
} */

class DifficultyPicker extends GetView<SettingsController> {
  DifficultyPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: controller.difficultyList
          .map((e) => MultiSelectItem(e.value, e.label))
          .toList(),
      listType: MultiSelectListType.CHIP,
      onConfirm: controller.difficultyPicker,
      title: Text('difficulty_picker__title'.tr),
      buttonText: Text('difficulty_picker__text'.tr),
      cancelText: Text('picker_cancel'.tr),
      confirmText: Text('picker_confirm'.tr),
      initialValue: controller.difficultyPicker,
    );
  }
}
