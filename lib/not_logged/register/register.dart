import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/register_controller.dart';
import 'package:pixtrip/main.dart';
import 'package:pixtrip/not_logged/continue_with.dart';
import 'package:pixtrip/not_logged/register/inputs.dart';
import 'package:pixtrip/not_logged/stay_connected.dart';

Controller c = Get.find();

class Register extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
          child: Column(
            children: [
              Mail(),
              SizedBox(height: 20.0),
              Pseudo(),
              SizedBox(height: 20.0),
              Password(),
              SizedBox(height: 25.0),
              StayConnected(),
              AcceptConditions(),
              SizedBox(height: 20.0),
              CreateAccount(),
              ContinueWith(),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAccount extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading()
          ? CircularProgressIndicator.adaptive()
          : ElevatedButton(
              onPressed: () => controller.addUser(),
              child: Text('register__create_account'.tr),
            ),
    );
  }
}
