import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/profil/change_password.dart';

Controller c = Get.find();

class Pseudo extends StatefulWidget {
  @override
  _PseudoState createState() => _PseudoState();
}

class _PseudoState extends State<Pseudo> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = c.userPseudo.value;
    c.setProfilPseudo(c.userPseudo.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    c.setProfilPseudo('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    );

    return SizedBox(
      width: Get.width * 0.6,
      child: TextField(
        textAlign: TextAlign.left,
        controller: _controller,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.create),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          focusedBorder: _inputBorder,
          enabledBorder: _inputBorder,
        ),
        onChanged: (text) => c.setProfilPseudo(text),
      ),
    );
  }
}

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = c.userMail.value;
    c.setProfilEmail(c.userMail.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    c.setProfilEmail('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.create),
      ),
      onChanged: (text) => c.setProfilEmail(text),
    );
  }
}

class Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ChangePassword()),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: IgnorePointer(
        ignoring: true,
        child: TextField(
          decoration: InputDecoration(
            hintText: '**********',
            suffixIcon: Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

class Age extends StatefulWidget {
  @override
  _AgeState createState() => _AgeState();
}

class _AgeState extends State<Age> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = c.userAge.value > 0 ? c.userAge.value.toString() : '';
    c.setProfilAge(c.userAge.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    c.setProfilAge(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: Get.width * 0.4,
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'profil__age_placeholder'.tr,
            suffixIcon: Icon(Icons.create),
          ),
          onChanged: (text) => c.setProfilAge(int.parse(text)),
        ),
      ),
    );
  }
}

class OldPassword extends StatefulWidget {
  @override
  _OldPasswordState createState() => _OldPasswordState();
}

class _OldPasswordState extends State<OldPassword> {
  TextEditingController _controller;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    c.setProfilOldPassword('');
    super.dispose();
  }

  void toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData suffixIcon =
        _obscureText ? Icons.visibility : Icons.visibility_off;

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'profil__old_password'.tr,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () => toggleObscureText(),
        ),
      ),
      obscureText: _obscureText,
      onChanged: (text) => c.setProfilOldPassword(text),
    );
  }
}

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController _controller;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    c.setProfilOldPassword('');
    super.dispose();
  }

  void toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData suffixIcon =
        _obscureText ? Icons.visibility : Icons.visibility_off;

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'profil__new_password'.tr,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () => toggleObscureText(),
        ),
      ),
      obscureText: _obscureText,
      onChanged: (text) => c.setProfilNewPassword(text),
    );
  }
}
