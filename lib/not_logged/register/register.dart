import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';
import 'package:pixtrip/not_logged/continue_with.dart';
import 'package:pixtrip/not_logged/register/inputs.dart';
import 'package:pixtrip/not_logged/stay_connected.dart';

Controller c = Get.find();

class Register extends StatelessWidget {
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

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _loading = false;

  void addUser() {
    c.checkHttpResponse(
        url: 'user/add_user.php',
        data: {
          'email': c.registerEmail.value,
          'pseudo': c.registerPseudo.value,
          'password': c.registerPassword.value,
        },
        loading: () => setState(() => _loading = true),
        error: () => setState(() => _loading = false),
        callBack: (data) {
          c.setUserId(data['u_id']);
          c.setUserMail(c.registerEmail.value);
          c.setUserPseudo(c.registerPseudo.value);
          if (c.stayConnected.value) {
            final box = GetStorage();
            box.write('user', {
              'id': data['u_id'],
              'mail': data['email'],
              'pseudo': data['pseudo'],
              'image': data['image'],
              'age': data['age'],
            });
          }
          Get.offAll(() => App());
        });
  }

  @override
  Widget build(BuildContext context) {
    print(c.registerEmail.value);
    print(c.registerPseudo.value);
    print(c.registerPassword.value);
    return _loading
        ? CircularProgressIndicator.adaptive()
        : Obx(
            () => IgnorePointer(
              ignoring: !c.registerAcceptedConditions.value,
              child: ElevatedButton(
                onPressed: () => addUser(),
                child: Text('register__create_account'.tr.toUpperCase()),
              ),
            ),
          );
  }
}
