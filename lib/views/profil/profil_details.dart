import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/bottom_navigation_bar.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/components/home/tutorial.dart';

import 'package:pixtrip/components/profil/user_image.dart';
import 'package:pixtrip/components/profil/inputs.dart';
import 'package:pixtrip/components/profil/buttons.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/login_controller.dart';
import 'package:pixtrip/controllers/tab_controller.dart';
import 'package:pixtrip/main.dart';
import 'package:pixtrip/not_logged/login/login.dart';

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.lightbulb),
        onPressed: () => Get.dialog(
          Tutorial(),
          barrierColor: Colors.transparent,
        ),
      ),
    );
  }
}

class UserRow extends StatelessWidget {
  void showLogOutPopin() {
    Get.defaultDialog(
      title: 'attention_title'.tr,
      content: Text('profil__logout_text'.tr),
      textConfirm: 'yes'.tr,
      textCancel: 'no'.tr,
      confirmTextColor: Colors.white,
      cancelTextColor: redColor[900],
      buttonColor: redColor[900],
      onConfirm: restart,
    );
  }

  void restart() {
    final box = GetStorage();
    box.remove('user');
    Get.delete<Controller>(force: true);
    Get.delete<MyTabController>(force: true);
    Get.delete<LoginController>(force: true);
    Get.put(Controller());
    Get.lazyPut(() => LoginController());
    Get.offAll(() => Login());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserImage(),
        SizedBox(width: 15.0),
        Pseudo(),
        IconButton(
          onPressed: showLogOutPopin,
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }
}
