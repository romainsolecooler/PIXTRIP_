import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';

class ProfilController extends GetxController {
  final loading = false.obs;
  final email = ''.obs;
  final pseudo = ''.obs;
  final age = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Controller c = Get.find();
    email(c.userMail());
    pseudo(c.userPseudo());
    age(c.userAge());
  }

  void updateProfil() async {
    loading(true);
    String _email = email().trim();
    String _pseudo = pseudo().trim();
    int _age = age();
    if (_email == '' || _pseudo == '') {
      showErrorMessage('change_profil__empty');
      return;
    }
    if (!GetUtils.isEmail(_email)) {
      showErrorMessage('change_profil__invalid_email');
      return;
    }
    if (_age < 1 || _age > 120) {
      showErrorMessage('change_profil__invalid_age');
      return;
    }
    var response = await dio.post('user/modify_user.php', data: {
      'email': _email,
      'pseudo': _pseudo,
      'age': _age,
      'u_id': c.userId.value,
    });
    var data = response.data;
    logger.d(data);
    if (data['error'] != null && data['error']) {
      logger.d(data['message']);
      showErrorMessage('change_profil__error'.tr);
      return;
    } else {
      Get.defaultDialog(
        title: 'profil__changed_success_title'.tr,
        content: Text(
          'profil__changed_success_text'.tr,
        ),
        textConfirm: 'ok'.tr,
        confirmTextColor: Colors.white,
        buttonColor: redColor[900],
        onConfirm: Get.back,
      );
      c.setUserMail(_email);
      c.setUserPseudo(_pseudo);
      c.setUserAge(_age);
    }
    loading(false);
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
