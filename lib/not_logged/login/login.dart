import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';

import 'package:pixtrip/not_logged/continue_with.dart';
import 'package:pixtrip/not_logged/forgot_password/forgot_password.dart';
import 'package:pixtrip/not_logged/login/inputs.dart';
import 'package:pixtrip/not_logged/register/register.dart';

Controller c = Get.find();

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
    );
  }
}

class Continue extends StatefulWidget {
  @override
  _ContinueState createState() => _ContinueState();
}

class _ContinueState extends State<Continue> {
  bool _loading = false;

  void connectUser() {
    c.checkHttpResponse(
      url: 'user/connect_user.php',
      data: {
        'email_pseudo': c.loginPseudoMail.value,
        'password': c.loginPassword.value,
      },
      loading: () => setState(() => _loading = true),
      error: () => setState(() => _loading = false),
      callBack: (data) {
        c.setUserId(data['u_id']);
        c.setUserMail(data['email']);
        c.setUserPseudo(data['pseudo']);
        if (c.stayConnected.value) {
          final box = GetStorage();
          box.write('user', {
            'id': data['u_id'],
            'mail': data['email'],
            'pseudo': data['pseudo'],
          });
        }
        Get.offAll(() => App());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _loading
        ? CircularProgressIndicator.adaptive()
        : Text('login__continue'.tr);
    return ElevatedButton(
      onPressed: () => connectUser(),
      child: child,
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
