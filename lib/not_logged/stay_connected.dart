import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

class StayConnected extends GetView<Controller> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        Obx(() => Checkbox(
              onChanged: (value) => controller.stayConnected(value),
              value: controller.stayConnected(),
            )),
        Text('login__stay_connected'.tr),
      ],
    );
  }
}
