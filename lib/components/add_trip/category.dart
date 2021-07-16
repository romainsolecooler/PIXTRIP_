import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

class Category extends GetView<Controller> {
  const Category({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> items = <String>[
      'cultural',
      'architectural',
      'point_of_view',
      'artistic',
      'flora_and_fauna',
      'unusual',
      'instagrammable',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value.tr),
      );
    }).toList();
    return Obx(() => DropdownButton(
          items: items,
          onChanged: controller.addCategory,
          value: controller.addCategory(),
        ));
  }
}
