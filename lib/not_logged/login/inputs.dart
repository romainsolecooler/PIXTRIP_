import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/login_controller.dart';

Controller c = Get.find();

class PseudoMail extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: 'login__pseudo_mail'.tr,
        prefixIcon: Icon(Icons.perm_identity),
      ),
      onChanged: (text) => controller.pseudoMail(text),
    );
  }
}

class Password extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      IconData suffixIcon =
          controller.obscureText() ? Icons.visibility : Icons.visibility_off;
      return TextField(
        textAlign: TextAlign.left,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: 'login__password'.tr,
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: () => controller.obscureText.toggle(),
          ),
        ),
        obscureText: controller.obscureText(),
        onChanged: (text) => controller.password(text),
      );
    });
  }
}
