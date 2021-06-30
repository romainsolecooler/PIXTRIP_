import 'package:get/get.dart';
import 'package:pixtrip/controllers/compass_controller.dart';

class CompassBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CompassController());
  }
}
