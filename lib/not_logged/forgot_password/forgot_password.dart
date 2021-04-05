import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';

import 'package:pixtrip/controllers/controller.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 45.0, 15.0, 10.0),
        child: Column(
          children: [
            Text(
              'forgot_password__title'.tr,
            ),
            SizedBox(height: 45.0),
            Mail(),
            GetBackPassword(),
          ],
        ),
      ),
    );
  }
}

Controller c = Get.find();

class Mail extends StatefulWidget {
  @override
  _MailState createState() => _MailState();
}

class _MailState extends State<Mail> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.text = c.forgotPasswordMail.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      onChanged: (text) => c.setForgotPasswordMail(text),
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'forgot_password__placeholder'.tr,
      ),
    );
  }
}

class GetBackPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ElevatedButton(
          child: Text('forgot_password__get_back_password'.tr.toUpperCase()),
          onPressed: () => Get.defaultDialog(
              title: 'Mail envoyé !',
              content: Text(
                  "Un mail vient d'être envoyé à votre adresse mail. Merci de suivre les instructions.")),
        ),
      ),
    );
  }
}
