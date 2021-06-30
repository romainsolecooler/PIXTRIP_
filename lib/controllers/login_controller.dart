import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';

Controller c = Get.find();

class LoginController extends GetxController {
  final loading = false.obs;
  final pseudoMail = ''.obs;
  final password = ''.obs;
  final obscureText = true.obs;

  void login() async {
    loading(true);
    String _pseudoMail = pseudoMail().trim();
    String _password = password().trim();
    if (_pseudoMail == '' || _password == '') {
      showErrorMessage('login__error_empty');
      return;
    }
    var response = await dio.post(
      'user/connect_user.php',
      data: {
        'email_pseudo': _pseudoMail,
        'password': _password,
      },
    );
    var data = response.data;
    if (data['error'] != null) {
      showErrorMessage('login__failed');
      return;
    } else {
      c.setUserId(data['u_id']);
      c.setUserMail(data['email']);
      c.setUserPseudo(data['pseudo']);
      c.setUserImage(data['image']);
      c.setUserAge(data['age']);
      c.setTutorialStep(data['tutorial']);
      if (c.stayConnected.value) {
        final box = GetStorage();
        box.write('user', data['u_id']);
      }
      Get.offAll(() => App());
    }
  }

  void showErrorMessage(String text) {
    loading(false);
    Get.defaultDialog(
      title: 'error_title'.tr,
      content: Text(
        text.tr,
        textAlign: TextAlign.center,
      ),
    );
  }
}
