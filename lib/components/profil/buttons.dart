import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class ValidateProfilChange extends StatefulWidget {
  @override
  _ValidateProfilChangeState createState() => _ValidateProfilChangeState();
}

class _ValidateProfilChangeState extends State<ValidateProfilChange> {
  bool _loading = false;

  void sendChanges() {
    c.checkHttpResponse(
        url: 'user/modify_user.php',
        data: {
          'email': c.profilEmail.value,
          'pseudo': c.profilPseudo.value,
          'age': c.profilAge.value,
          'u_id': c.userId.value,
        },
        loading: () => setState(() => _loading = true),
        error: () => setState(() => _loading = false),
        callBack: (data) {
          setState(() => _loading = false);
          Get.defaultDialog(
              title: 'profil__changed_success_title'.tr,
              content: Text(
                'profil__changed_success_text'.tr,
              ));
          c.setUserMail(c.profilEmail.value);
          c.setUserPseudo(c.profilPseudo.value);
          c.setUserAge(c.profilAge.value);
          final box = GetStorage();
          Map<String, dynamic> user = box.read('user');
          if (user != null) {
            box.write('user', {
              'id': c.userId.value,
              'mail': c.userMail.value,
              'pseudo': c.userPseudo.value,
              'image': c.userImage.value,
              'age': c.userAge.value
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator.adaptive()
        : ElevatedButton(
            child: Text('profil__validate_changes'.tr),
            onPressed: () => sendChanges(),
          );
  }
}

class ValidateNewPassword extends StatefulWidget {
  @override
  _ValidateNewPasswordState createState() => _ValidateNewPasswordState();
}

class _ValidateNewPasswordState extends State<ValidateNewPassword> {
  bool _loading = false;

  void changePassword() {
    c.checkHttpResponse(
        url: 'user/change_password.php',
        data: {
          'old_password': c.profilOldPassword.value,
          'new_password': c.profilNewPassword.value,
          'u_id': c.userId.value,
        },
        loading: () => setState(() => _loading = true),
        error: () => setState(() => _loading = false),
        callBack: (data) {
          setState(() => _loading = false);
          Get.defaultDialog(
              title: 'profil__changed_password_title'.tr,
              content: Text(
                'profil__changed_password_text'.tr,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator.adaptive()
        : ElevatedButton(
            child: Text('profil__validate_changes'.tr),
            onPressed: () => changePassword(),
          );
  }
}
