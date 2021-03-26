import 'package:get/get.dart';

class Controller extends GetxController {
  var fetch = GetConnect();

  ////////////
  // TRIPS //
  ///////////
  final settingsCityName = ''.obs;
  final sliderDistance = 4.0.obs;
  final sliderTime = 3.obs;
  final sliderDifficulty = 2.obs;

  void setSettingsCityName(String city) {
    settingsCityName.value = city;
  }

  void setSliderDistance(double value) {
    sliderDistance.value = value;
  }

  void setSliderTime(int value) {
    sliderTime.value = value;
  }

  void setSliderDifficulty(int value) {
    sliderDifficulty.value = value;
  }

  //////////////
  // ADD TRIP //
  //////////////
  final addCityName = ''.obs;
  final addFirstInfo = ''.obs;
  final addSecondInfo = ''.obs;
  final addThirdInfo = ''.obs;

  void setAddCityName(String city) {
    addCityName.value = city;
  }

  void setAddFirstInfo(String text) {
    addFirstInfo.value = text;
  }

  void setAddSecondInfo(String text) {
    addSecondInfo.value = text;
  }

  void setAddThirdInfo(String text) {
    addThirdInfo.value = text;
  }

  ////////////
  // WALLET //
  ////////////
  final couponId = ''.obs;

  void setCouponId(String id) {
    couponId.value = id;
  }
}
