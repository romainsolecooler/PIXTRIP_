import 'package:flutter/material.dart';

import 'package:pixtrip/common/app_bar.dart';

import 'package:pixtrip/components/profil/inputs.dart';
import 'package:pixtrip/components/profil/buttons.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OldPassword(),
              SizedBox(height: 20.0),
              NewPassword(),
              SizedBox(height: 100.0),
              ValidateNewPassword(),
            ],
          ),
        ),
      ),
    );
  }
}
