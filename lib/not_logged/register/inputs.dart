import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

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
    _controller.text = c.registerEmail.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: 'register__mail'.tr,
        prefixIcon: Icon(Icons.email),
      ),
      onChanged: (text) => c.setRegisterEmail(text),
    );
  }
}

class Pseudo extends StatefulWidget {
  @override
  _PseudoState createState() => _PseudoState();
}

class _PseudoState extends State<Pseudo> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.text = c.registerPseudo.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: 'register__pseudo'.tr,
        prefixIcon: Icon(Icons.perm_identity),
      ),
      onChanged: (text) => c.setRegisterPseudo(text),
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
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.text = c.registerPassword.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      decoration: InputDecoration(
        hintText: 'register__password'.tr,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () => toggleObscureText(),
        ),
      ),
      obscureText: obscureText,
      onChanged: (text) => c.setRegisterPassword(text),
      controller: _controller,
    );
  }
}

class AcceptConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.0),
        Obx(() => Checkbox(
              onChanged: (value) => c.registerAcceptedConditions(value),
              value: c.registerAcceptedConditions.value,
            )),
        Text('register__accept_conditions'.tr),
      ],
    );
  }
}
