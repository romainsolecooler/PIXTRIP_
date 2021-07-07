import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/bindings/profil_password_binding.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/profil_controller.dart';
import 'package:pixtrip/controllers/profil_password_controller.dart';
import 'package:pixtrip/views/profil/change_password.dart';

Controller c = Get.find();

class Pseudo extends GetView<ProfilController> {
  final TextEditingController _controller = TextEditingController(
    text: c.userPseudo(),
  );

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    );

    return Expanded(
      child: TextField(
        textAlign: TextAlign.left,
        controller: _controller,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.create),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        ),
        onChanged: (text) => controller.pseudo(text),
      ),
    );
  }
}

class Email extends GetView<ProfilController> {
  final TextEditingController _controller = TextEditingController(
    text: c.userMail(),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.create),
      ),
      onChanged: (text) => controller.email(text),
    );
  }
}

class Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        () => ChangePassword(),
        binding: ProfilPasswordBinding(),
      ),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: IgnorePointer(
        ignoring: true,
        child: TextField(
          decoration: InputDecoration(
            hintText: '**********',
            suffixIcon: Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

class Age extends GetView<ProfilController> {
  final TextEditingController _controller = TextEditingController(
    text: c.userAge.value > 0 ? c.userAge.value.toString() : '',
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: Get.width * 0.4,
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'profil__age_placeholder'.tr,
            suffixIcon: Icon(Icons.create),
          ),
          onChanged: (text) {
            int age = text == '' ? 0 : int.parse(text);
            controller.age(age);
          },
        ),
      ),
    );
  }
}

class OldPassword extends GetView<ProfilPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      IconData suffixIcon =
          !controller.hideOld() ? Icons.visibility : Icons.visibility_off;
      return TextField(
        decoration: InputDecoration(
          hintText: 'profil__old_password'.tr,
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: controller.hideOld.toggle,
          ),
        ),
        obscureText: controller.hideOld(),
        onChanged: (text) => controller.oldPassword(text),
      );
    });
  }
}

class NewPassword extends GetView<ProfilPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      IconData suffixIcon =
          !controller.hideNew() ? Icons.visibility : Icons.visibility_off;
      return TextField(
        decoration: InputDecoration(
          hintText: 'profil__old_password'.tr,
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: controller.hideNew.toggle,
          ),
        ),
        obscureText: controller.hideNew(),
        onChanged: (text) => controller.newPassword(text),
      );
    });
  }
}
