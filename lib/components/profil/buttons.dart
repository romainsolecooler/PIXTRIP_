import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/custom_colors.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/profil_controller.dart';
import 'package:pixtrip/controllers/profil_password_controller.dart';

Controller c = Get.find();

class ValidateProfilChange extends GetView<ProfilController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading()
        ? CircularProgressIndicator.adaptive()
        : ElevatedButton(
            child: Text('profil__validate_changes'.tr),
            onPressed: () {
              FocusScope.of(context).unfocus();
              controller.updateProfil();
            },
          ));
  }
}

class ValidateNewPassword extends GetView<ProfilPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading()
        ? CircularProgressIndicator.adaptive()
        : ElevatedButton(
            child: Text('profil__validate_changes'.tr),
            onPressed: () {
              FocusScope.of(context).unfocus();
              controller.updatePassword();
            },
          ));
  }
}
