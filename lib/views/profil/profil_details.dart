import 'package:flutter/material.dart';

import 'package:pixtrip/common/app_bar.dart';

import 'package:pixtrip/components/profil/user_image.dart';
import 'package:pixtrip/components/profil/inputs.dart';
import 'package:pixtrip/components/profil/buttons.dart';

const double indent = 15.0;
const double dividerIndent = indent * 2;

class ProfilDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(indent),
            child: Column(
              children: [
                UserRow(),
                Divider(
                  indent: dividerIndent,
                  endIndent: dividerIndent,
                  height: 50,
                ),
                SizedBox(height: 25.0),
                Email(),
                SizedBox(height: 20.0),
                Password(),
                SizedBox(height: 20.0),
                Age(),
                SizedBox(height: 60.0),
                ValidateProfilChange(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserImage(),
        SizedBox(width: 15.0),
        Pseudo(),
      ],
    );
  }
}
