import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Placeholder(
          fallbackWidth: 50,
          fallbackHeight: 50,
        ),
        Placeholder(
          fallbackWidth: 50,
          fallbackHeight: 50,
        ),
      ],
    );
  }
}
