import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/controllers/controller.dart';

class ChooseType extends GetView<Controller> {
  const ChooseType({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Text(
          'urban'.tr,
          textAlign: TextAlign.right,
        )),
        Obx(() => Switch(
              value: controller.addType(),
              onChanged: controller.setAddType,
              activeColor: redColor[900],
              inactiveTrackColor: redColor[500],
              inactiveThumbColor: redColor[900],
            )),
        Expanded(child: Text('country'.tr)),
      ],
    );
  }
}
