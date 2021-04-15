import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Controller extends GetxController {
  var fetch = GetConnect();

  void checkHttpResponse(
      {String url,
      Map<String, dynamic> data,
      Function loading,
      Function callBack,
      Function error}) {
    loading();
    fetch.post(url, data).then((value) {
      if (value.body is List) {
        callBack(value.body);
        return;
      }
      if (value.body['error'] != null && value.body['error']) {
        Get.defaultDialog(
          title: 'error_title'.tr,
          content: Text(value.body['message']),
        );
        error();
      } else {
        callBack(value.body);
      }
    });
  }

  //////////
  // USER //
  //////////
  final userId = ''.obs;
  final userMail = ''.obs;
  final userPseudo = ''.obs;

  void setUserId(String id) {
    userId.value = id;
  }

  void setUserMail(String mail) {
    userMail.value = mail;
  }

  void setUserPseudo(String pseudo) {
    userPseudo.value = pseudo;
  }

  ///////////
  // LOGIN //
  ///////////
  final loginPseudoMail = ''.obs;
  final loginPassword = ''.obs;
  final stayConnected = false.obs;

  void setLoginPseudoMail(String text) {
    loginPseudoMail.value = text;
  }

  void setLoginPassword(String text) {
    loginPassword.value = text;
  }

  void setStayConnected(bool newValue) {
    stayConnected.value = newValue;
  }

  //////////////
  // REGISTER //
  //////////////
  final registerEmail = ''.obs;
  final registerPseudo = ''.obs;
  final registerPassword = ''.obs;
  final registerAcceptedConditions = false.obs;

  void setRegisterEmail(String text) {
    registerEmail.value = text;
  }

  void setRegisterPseudo(String text) {
    registerPseudo.value = text;
  }

  void setRegisterPassword(String text) {
    registerPassword.value = text;
  }

  void setRegisterAcceptedConditions(bool newValue) {
    registerAcceptedConditions.value = newValue;
  }

  /////////////////////
  // FORGOT PASSWORD //
  /////////////////////
  final forgotPasswordMail = ''.obs;

  void setForgotPasswordMail(String text) {
    forgotPasswordMail.value = text;
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

  //////////
  // HOME //
  //////////
  final homeTrips = <dynamic>[].obs;

  void setHomeTrips(List<dynamic> trips) {
    homeTrips.value = trips;
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
  final tripsList = <dynamic>[].obs;

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

  void setTripsList(List<dynamic> trips) {
    tripsList.value = trips;
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
