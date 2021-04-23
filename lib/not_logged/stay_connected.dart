import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class StayConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        Obx(() => Checkbox(
              onChanged: (value) => c.setStayConnected(value),
              value: c.stayConnected.value,
            )),
        Text('login__stay_connected'.tr),
      ],
    );
  }
}
