import 'package:get/get.dart';
import 'package:pixtrip/controllers/profil_controller.dart';

class ProfilBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfilController());
  }
}
