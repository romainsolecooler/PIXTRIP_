import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/register_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class Mail extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: 'register__mail'.tr,
        prefixIcon: Icon(Icons.email),
      ),
      onChanged: (text) => controller.email(text),
    );
  }
}

class Pseudo extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: 'register__pseudo'.tr,
        prefixIcon: Icon(Icons.perm_identity),
      ),
      onChanged: (text) => controller.pseudo(text),
    );
  }
}

class Password extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      IconData suffixIcon =
          controller.obscureText() ? Icons.visibility : Icons.visibility_off;
      return TextField(
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: 'register__password'.tr,
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

class AcceptConditions extends GetView<RegisterController> {
  void _openCGU() async {
    await launch('https://pixtrip.fr/politique-de-confidentialite.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.0),
        Obx(() => Checkbox(
              onChanged: (value) => controller.acceptedConditions(value),
              value: controller.acceptedConditions(),
            )),
        GestureDetector(
          onTap: _openCGU,
          child: Text('register__accept_conditions'.tr),
        ),
      ],
    );
  }
}
