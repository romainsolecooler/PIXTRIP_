import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class MyTabController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;

  void to({int index, bool resetFinishedTrip = true}) {
    tabController.index = index;
    if (resetFinishedTrip) {
      c.setFinishedTrip(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 5);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
