import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';

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

class GetBackPassword extends StatefulWidget {
  @override
  _GetBackPasswordState createState() => _GetBackPasswordState();
}

class _GetBackPasswordState extends State<GetBackPassword> {
  bool _loading = false;
  void getBackPassword() async {
    setState(() => _loading = true);
    var response = await dio.post(
      'user/forgot_password.php',
      data: {'email': c.forgotPasswordMail.value},
    );
    var data = response.data;
    logger.d(data);
    String title = data['error'] ? 'error_title' : 'sucess_title';
    String text = data['error']
        ? 'forgot_password__error_text'
        : 'forgot_password__sucess_text';
    setState(() => _loading = false);
    Get.defaultDialog(
      title: title.tr,
      content: Text(text.tr),
    );
  }

  @override
  void dispose() {
    c.setForgotPasswordMail('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: _loading
            ? CircularProgressIndicator.adaptive()
            : ElevatedButton(
                child:
                    Text('forgot_password__get_back_password'.tr.toUpperCase()),
                onPressed: () => getBackPassword(),
              ),
      ),
    );
  }
}
