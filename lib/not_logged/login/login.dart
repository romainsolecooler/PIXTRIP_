import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_transition_button/loading_transition_button.dart';
import 'package:pixtrip/common/animated_button.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';

import 'package:pixtrip/not_logged/continue_with.dart';
import 'package:pixtrip/not_logged/forgot_password/forgot_password.dart';
import 'package:pixtrip/not_logged/login/inputs.dart';
import 'package:pixtrip/not_logged/register/register.dart';
import 'package:pixtrip/not_logged/stay_connected.dart';

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

class Continue extends StatefulWidget {
  @override
  _ContinueState createState() => _ContinueState();
}

class _ContinueState extends State<Continue> {
  bool _loading = false;
  LoadingButtonController _controller;

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
        c.setUserImage(data['image']);
        c.setUserAge(data['age']);
        c.setTutorialStep(data['tutorial']);
        if (c.stayConnected.value) {
          final box = GetStorage();
          box.write('user', data['u_id']);
        }
        Get.offAll(() => App());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = LoadingButtonController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* return AnimatedButton(
      callBack: () => connectUser(),
    ); */
    return _loading
        ? CircularProgressIndicator.adaptive()
        : ElevatedButton(
            onPressed: () => connectUser(),
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
