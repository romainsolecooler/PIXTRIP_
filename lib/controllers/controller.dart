import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Controller extends GetxController {
  var fetch = GetConnect();

  void checkHttpResponse(
      {String url,
      dynamic data,
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

  void printUserData() {
    print('user data : ');
    print('user mail : ${userMail.value}');
    print('user pseudo : ${userPseudo.value}');
    print('user age : ${userAge.value}');
    print('user image : ${userImage.value}');
  }

  void printProfilData() {
    print('user data : ');
    print('user mail : ${profilEmail.value}');
    print('user pseudo : ${profilPseudo.value}');
    print('user age : ${profilAge.value}');
  }

  //////////
  // USER //
  //////////
  final userId = ''.obs;
  final userMail = ''.obs;
  final userPseudo = ''.obs;
  final userImage = ''.obs;
  final userAge = 0.obs;

  void setUserId(String id) {
    userId.value = id;
  }

  void setUserMail(String mail) {
    userMail.value = mail;
  }

  void setUserPseudo(String pseudo) {
    userPseudo.value = pseudo;
  }

  void setUserImage(String image) {
    if (image != '') {
      userImage.value = 'https://pixtrip.fr/images/users/$image';
    }
  }

  void setUserAge(int age) {
    userAge.value = age;
    print(userAge.value);
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

  //////////
  // TRIP //
  //////////
  final tripSelectedFromHome = false.obs;
  final tripId = 0.obs;
  final tripCity = ''.obs;
  final tripImage = ''.obs;
  final tripDifficulty = 0.obs;
  final tripTime = 0.obs;
  final tripDistance = 0.obs;
  final tripLatitude = 0.0.obs;
  final tripLongitude = 0.0.obs;
  final tripAltitude = 0.0.obs;
  final tripAnecdote_1 = ''.obs;
  final tripAnecdote_2 = ''.obs;
  final tripAnecdote_3 = ''.obs;

  void setTripSelectedFromHome(bool newValue) {
    tripSelectedFromHome.value = newValue;
  }

  void setTrip(Map<String, dynamic> trip) {
    tripId.value = trip['id'];
    tripCity.value = trip['city'];
    tripImage.value = trip['image'];
    tripDifficulty.value = trip['difficulty'];
    tripTime.value = trip['time'];
    tripDistance.value = trip['distance'];
    tripLatitude.value = trip['latitude'];
    tripLongitude.value = trip['longitude'];
    tripAltitude.value = trip['altitude'];
    tripAnecdote_1.value = trip['anecdote_1'];
    tripAnecdote_2.value = trip['anecdote_2'];
    tripAnecdote_3.value = trip['anecdote_3'];
  }

  ////////////
  // TRIPS //
  ///////////
  final settingsCityName = ''.obs;
  final settingsCurrentPosition = false.obs;
  final sliderDistance = 4.obs;
  final sliderTime = 3.obs;
  final sliderDifficulty = 2.obs;
  final tripsList = <dynamic>[].obs;

  void setSettingsCurrentPosition(bool newValue) {
    settingsCurrentPosition.value = newValue;
  }

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

  ////////////
  // PROFIL //
  ////////////
  final profilPseudo = ''.obs;
  final profilEmail = ''.obs;
  final profilAge = 0.obs;
  final profilOldPassword = ''.obs;
  final profilNewPassword = ''.obs;

  void setProfilPseudo(String pseudo) {
    profilPseudo.value = pseudo;
  }

  void setProfilEmail(String email) {
    profilEmail.value = email;
  }

  void setProfilAge(int age) {
    profilAge.value = age;
  }

  void setProfilOldPassword(String oldPassword) {
    profilOldPassword.value = oldPassword;
  }

  void setProfilNewPassword(String newPassword) {
    profilNewPassword.value = newPassword;
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
  final usedCoupons = <dynamic>[].obs;
  final usedCouponsLoaded = false.obs;
  final unusedCoupons = <dynamic>[].obs;
  final unusedCouponsLoaded = false.obs;
  final couponId = ''.obs;

  void setUsedCoupons(List<dynamic> couponsList) {
    usedCoupons.value = couponsList;
    usedCouponsLoaded.value = true;
  }

  void setUnusedCoupons(List<dynamic> couponsList) {
    unusedCoupons.value = couponsList;
    unusedCouponsLoaded.value = true;
  }

  void setCouponId(String id) {
    couponId.value = id;
  }
}
