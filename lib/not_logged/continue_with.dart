import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auth_buttons/auth_buttons.dart';

class ContinueWith extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Column(
        children: [
          Divider(height: 40.0),
          Text('login__or_continue_with'.tr),
          SizedBox(height: 40.0),
          OAuthRow(),
        ],
      ),
    );
  }
}

class OAuthRow extends StatelessWidget {
  final AuthButtonStyle _authButtonStyle = AuthButtonStyle(
    buttonType: AuthButtonType.icon,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GoogleAuthButton(
          onPressed: () {},
          darkMode: false,
          style: _authButtonStyle,
        ),
        FacebookAuthButton(
          onPressed: () {},
          style: _authButtonStyle,
        ),
      ],
    );
  }
}
