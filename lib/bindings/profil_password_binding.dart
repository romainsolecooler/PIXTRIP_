import 'package:get/get.dart';
import 'package:pixtrip/controllers/profil_password_controller.dart';

class ProfilPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfilPasswordController());
  }
}
