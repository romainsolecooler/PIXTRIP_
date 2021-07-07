import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/common/utils.dart';

class ProfilPasswordController extends GetxController {
  final loading = false.obs;
  final oldPassword = ''.obs;
  final newPassword = ''.obs;

  final hideOld = true.obs;
  final hideNew = true.obs;

  void updatePassword() async {
    loading(true);
    String _oldPassword = oldPassword().trim();
    String _newPassword = newPassword().trim();
    if (_oldPassword == '' || _newPassword == '') {
      showMessage(text: 'change_password__error_empty');
      return;
    }
    if (_oldPassword == _newPassword) {
      showMessage(text: 'change_password__error_same');
      return;
    }
    var response = await dio.post(
      'user/change_password.php',
      data: {
        'old_password': _oldPassword,
        'new_password': _newPassword,
        'u_id': c.userId.value,
      },
    );
    var data = response.data;
    if (data['error'] != null && data['error']) {
      showMessage(text: 'change_password__error_wrong');
      return;
    } else {
      showMessage(title: 'sucess_title', text: 'change_password__success_text');
    }
    loading(false);
  }

  void showMessage({String title = 'error_title', String text}) {
    loading(false);
    Get.defaultDialog(
      title: title.tr,
      content: Text(
        text.tr,
        textAlign: TextAlign.center,
      ),
      textConfirm: 'ok'.tr,
      confirmTextColor: Colors.white,
      buttonColor: redColor[900],
      onConfirm: Get.back,
    );
  }
}
