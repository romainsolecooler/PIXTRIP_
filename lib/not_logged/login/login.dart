import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/login_controller.dart';
import 'package:pixtrip/main.dart';

import 'package:pixtrip/not_logged/continue_with.dart';
import 'package:pixtrip/not_logged/forgot_password/forgot_password.dart';
import 'package:pixtrip/not_logged/login/inputs.dart';
import 'package:pixtrip/not_logged/register/register.dart';
import 'package:pixtrip/not_logged/stay_connected.dart';

//LoginController loginController = Get.put(LoginController());
Controller c = Get.find();

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
          child: Column(
            children: [
              CreateAccount(),
              SizedBox(height: 30.0),
              PseudoMail(),
              SizedBox(height: 25.0),
              Password(),
              SizedBox(height: 20.0),
              StayConnected(),
              SizedBox(height: 20.0),
              Continue(),
              ContinueWith(),
              SizedBox(height: 25.0),
              GoToForgotPassword(),
            ],
          ),
        ),
      ),
    );
  }
}

class Continue extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading()
          ? CircularProgressIndicator.adaptive()
          : ElevatedButton(
              onPressed: () => controller.login(),
              child: Text('login__continue'.tr),
            ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'login__go_register'.tr,
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () => Get.to(() => Register()),
    );
  }
}

class GoToForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'login__forgotten_password'.tr,
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () => Get.to(() => ForgotPassword()),
    );
  }
}
