import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';

import 'controllers/controller.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
        child: Column(
          children: [
            Text('login__go_register'.tr),
            SizedBox(height: 50.0),
            PseudoMail(),
            SizedBox(height: 25.0),
            Password(),
          ],
        ),
      ),
    );
  }
}

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      placeholder: 'login__pseudo_mail'.tr,
      textAlign: TextAlign.left,
      cursorColor: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      prefix: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Icon(Icons.perm_identity),
      ),
      onChanged: (text) => print(text),
      controller: _controller,
    );
  }
}

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller;
  AnimationController _animationController;

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
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

    return CupertinoTextField(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      placeholder: 'login__password'.tr,
      textAlign: TextAlign.left,
      cursorColor: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      suffix: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () => toggleObscureText(),
        ),
      ),
      obscureText: obscureText,
      onChanged: (text) => print(text),
      controller: _controller,
    );
  }
}
