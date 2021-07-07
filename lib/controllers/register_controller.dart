import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/main.dart';

Controller c = Get.find();

class RegisterController extends GetxController {
  final loading = false.obs;
  final email = ''.obs;
  final pseudo = ''.obs;
  final password = ''.obs;
  final obscureText = true.obs;
  final acceptedConditions = false.obs;

  void addUser() async {
    loading(true);
    String _email = email().trim();
    String _pseudo = pseudo().trim();
    String _password = password().trim();
    bool _acceptedConditions = acceptedConditions();
    if (!_acceptedConditions) {
      showErrorMessage('register__error_accept');
      return;
    }
    if (_email == '' || _pseudo == '' || _password == '') {
      showErrorMessage('register__error_empty');
      return;
    }
    if (!GetUtils.isEmail(_email)) {
      showErrorMessage('register__error_mail');
      return;
    }
    var response = await dio.post(
      'user/add_user.php',
      data: {
        'email': _email,
        'pseudo': _pseudo,
        'password': _password,
      },
    );
    var data = response.data;
    if (data['error'] != null) {
      showErrorMessage('register__error_exist');
      return;
    } else {
      c.setUserId(data['u_id']);
      c.setUserMail(_email);
      c.setUserPseudo(_pseudo);
      if (c.stayConnected.value) {
        final box = GetStorage();
        box.write('user', data['u_id']);
      }
      loading(false);
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
