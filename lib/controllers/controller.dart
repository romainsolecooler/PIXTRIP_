import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Controller extends GetxController {
  var fetch = GetConnect();

  //////////
  // USER //
  //////////

  ///////////
  // LOGIN //
  ///////////
  final loginPseudoMail = ''.obs;
  final loginPassword = ''.obs;
  final stayConnected = false.obs;

  void setLoginPseudoMail(String text) {
    loginPseudoMail.value = text;
    print(loginPseudoMail.value);
  }

  void setLoginPassword(String text) {
    loginPassword.value = text;
  }

  void setStayConnected(bool newValue) {
    stayConnected.value = newValue;
    print(stayConnected.value);
  }

  //////////////////////////////////
  // PERSISTENT APPBAR CONTROLLER //
  //////////////////////////////////
  final appBarController = PersistentTabController(
    initialIndex: 0,
  ).obs;

  void setAppBarController(int index) {
    appBarController.value.index = index;
  }

  /////////////////////////
  // TUTORIAL CONTROLLER //
  /////////////////////////
  final carouselController = CarouselController().obs;

  ////////////
  // TRIPS //
  ///////////
  final settingsCityName = ''.obs;
  final sliderDistance = 4.obs;
  final sliderTime = 3.obs;
  final sliderDifficulty = 2.obs;

  void setSettingsCityName(String city) {
    settingsCityName.value = city;
  }

  void setSliderDistance(int value) {
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
  final addDistance = 2.obs;
  final addTime = 3.obs;
  final addDifficulty = 2.obs;
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

  void setAddDistance(int value) {
    addDistance.value = value;
  }

  void setAddTime(int value) {
    addTime.value = value;
  }

  void setAddDifficulty(int value) {
    addDifficulty.value = value;
  }

  ////////////
  // WALLET //
  ////////////
  final couponId = ''.obs;

  void setCouponId(String id) {
    couponId.value = id;
  }
}
