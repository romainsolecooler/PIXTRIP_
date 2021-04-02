import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/not_logged/login/continue_with.dart';

import 'package:pixtrip/not_logged/login/inputs.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
        child: Column(
          children: [
            CreateAccount(),
            SizedBox(height: 30.0),
            PseudoMail(),
            SizedBox(height: 25.0),
            Password(),
            SizedBox(height: 20),
            StayConnected(),
            SizedBox(height: 20),
            Continue(),
            ContinueWith(),
            SizedBox(height: 25.0),
            ForgotPassword(),
          ],
        ),
      ),
    );
  }
}

class Continue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => print(null),
      child: Text('login__continue'.tr),
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
      onPressed: () => print('oto'),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'login__forgotten_password'.tr,
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () => print('oto'),
    );
  }
}
