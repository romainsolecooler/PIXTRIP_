import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/controllers/settings_controller.dart';

class Environment extends GetView<SettingsController> {
  const Environment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _IconColumn(
          icon: Icons.location_city,
          title: 'urban',
          controller: controller.showUrban,
        ),
        _IconColumn(
          icon: Icons.park,
          title: 'country',
          controller: controller.showCountry,
        ),
      ],
    );
  }
}

class _IconColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final RxBool controller;
  const _IconColumn({
    Key key,
    this.icon,
    this.title,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: controller.toggle,
        child: Column(
          children: [
            Obx(() => Icon(
                  icon,
                  size: 35.0,
                  color: controller()
                      ? redColor[900]
                      : Theme.of(context).textTheme.bodyText1.color,
                )),
            Text(title.tr),
          ],
        ),
      ),
    );
  }
}
