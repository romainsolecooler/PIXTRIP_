import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.put(Controller());

class PseudoMail extends StatefulWidget {
  @override
  _PseudoMailState createState() => _PseudoMailState();
}

class _PseudoMailState extends State<PseudoMail> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = c.loginPseudoMail.value;
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
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        hintText: 'login__pseudo_mail'.tr,
        prefixIcon: Icon(Icons.perm_identity),
      ),
      onChanged: (text) => c.setLoginPseudoMail(text),
      controller: _controller,
    );
  }
}

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController _controller;

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = c.loginPassword.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData suffixIcon = obscureText ? Icons.visibility : Icons.visibility_off;

    return TextField(
      textAlign: TextAlign.left,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        hintText: 'login__password'.tr,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () => toggleObscureText(),
        ),
      ),
      obscureText: obscureText,
      onChanged: (text) => c.setLoginPassword(text),
      controller: _controller,
    );
  }
}

class StayConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        Obx(() => Checkbox(
              onChanged: (value) => c.setStayConnected(value),
              value: c.stayConnected.value,
            )),
        Text('login__stay_connected'.tr),
      ],
    );
  }
}
