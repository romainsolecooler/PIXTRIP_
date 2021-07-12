import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pixtrip/controllers/settings_controller.dart';

class CategoryChoice extends GetView<SettingsController> {
  const CategoryChoice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: controller.categoryList
          .map((e) => MultiSelectItem(e.value, e.label.tr))
          .toList(),
      listType: MultiSelectListType.CHIP,
      onConfirm: controller.categoryPicker,
      title: Text('category_picker__title'.tr),
      buttonText: Text('category_picker__text'.tr),
      cancelText: Text('picker_cancel'.tr),
      confirmText: Text('picker_confirm'.tr),
      initialValue: controller.categoryPicker,
    );
  }
}
