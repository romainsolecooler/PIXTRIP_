import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/not_logged/continue_with.dart';
import 'package:pixtrip/not_logged/register/inputs.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
        child: Column(
          children: [
            Mail(),
            SizedBox(height: 20.0),
            Pseudo(),
            SizedBox(height: 20.0),
            Password(),
            SizedBox(height: 25.0),
            AcceptConditions(),
            SizedBox(height: 20.0),
            CreateAccount(),
            ContinueWith(),
          ],
        ),
      ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => print('creer le compte'),
      child: Text('register__create_account'.tr.toUpperCase()),
    );
  }
}
