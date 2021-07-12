import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

class StayConnected extends StatelessWidget {
  final RxBool controller;

  const StayConnected({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        Obx(() => Checkbox(
              onChanged: (value) => controller(value),
              value: controller(),
            )),
        Text('login__stay_connected'.tr),
      ],
    );
  }
}
