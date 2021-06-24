import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pixtrip/common/utils.dart';

class Controller extends GetxController {
  var fetch = GetConnect();

  void checkHttpResponse({
    String url,
    dynamic data,
    Function loading,
    Function callBack,
    Function error,
  }) {
    loading();
    fetch.post(url, data).then((value) {
      // logger.wtf(value.body);
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
  final loadingUserImage = false.obs;
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

  void setLoadingUserImage(bool newValue) {
    loadingUserImage.value = newValue;
  }

  void setUserImage(String image) {
    if (image != '') {
      userImage.value = image.contains('https://')
          ? image
          : 'https://pixtrip.fr/images/users/$image';
    }
  }

  void setUserAge(int age) {
    userAge.value = age;
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

  ///////////////////////////
  // BOTTOM BAR CONTROLLER //
  ///////////////////////////
  final tabBarController = PageController(initialPage: 0).obs;
  final currentIndex = 0.obs;

  void goToPage({int index, bool resetFinishedTrip = true}) {
    tabBarController.value.animateToPage(
      index,
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOut,
    );
    if (resetFinishedTrip) {
      setFinishedTrip(false);
    }
    currentIndex(index);
  }

  void goToPageWithoutTransition({int index, bool resetFinishedTrip = true}) {
    tabBarController.value.jumpToPage(index);
    if (resetFinishedTrip) {
      setFinishedTrip(false);
    }
    currentIndex(index);
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
  final tutorialStep = 0.obs;

  void setTutorialStep(int newValue) {
    tutorialStep.value = newValue;
  }

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
  final tripFromAdmin = false.obs;
  final tripUserId = ''.obs;
  final finishedTrip = false.obs;
  final currentUserLatitude = 0.0.obs;
  final currentUserLongitude = 0.0.obs;
  final currentUserAltitude = 0.0.obs;
  final couponList = <dynamic>[].obs;
  final positionList = <dynamic>[].obs;

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
    tripFromAdmin.value = trip['from_admin'];
    tripUserId.value = trip['user_id'];
  }

  void setFinishedTrip(bool finished) {
    finishedTrip.value = finished;
  }

  void setCurrentUserposition(
    double latitude,
    double longitude,
    double altitude,
  ) {
    currentUserLatitude.value = latitude;
    currentUserLongitude.value = longitude;
    currentUserAltitude.value = altitude;
  }

  void addPositionList(dynamic position) {
    positionList.add(position);
  }

  void setCouponList(List<dynamic> coupons) {
    couponList.value = coupons;
  }

  void setPositionList(List<dynamic> positions) {
    positionList.value = positions;
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
  final profilList = <dynamic>[].obs;

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

  void setProfilList(List<dynamic> trips) {
    profilList.value = trips;
  }

  //////////////
  // ADD TRIP //
  //////////////
  final addTripImage = File('').obs;
  final addLatitude = 0.0.obs;
  final addLongitude = 0.0.obs;
  final addAltitude = 0.0.obs;
  final addCityName = ''.obs;
  final addDistance = 2.obs;
  final addTime = 3.obs;
  final addDifficulty = 2.obs;
  final addFirstInfo = ''.obs;
  final addSecondInfo = ''.obs;
  final addThirdInfo = ''.obs;

  void setAddTripImage(File file) {
    addTripImage.value = file;
  }

  void setAddLatitude(double latitude) {
    addLatitude.value = latitude;
  }

  void setAddLongitude(double longitude) {
    addLongitude.value = longitude;
  }

  void setAddAltitude(double longitude) {
    addAltitude.value = longitude;
  }

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

  void deletedAddTripInfos() {
    addTripImage.value = File('');
    addLatitude.value = 0.0;
    addLongitude.value = 0.0;
    addAltitude.value = 0.0;
    addCityName.value = '';
    addFirstInfo.value = '';
    addSecondInfo.value = '';
    addThirdInfo.value = '';
    addDistance.value = 2;
    addTime.value = 3;
    addDifficulty.value = 1;
  }

  ////////////
  // WALLET //
  ////////////
  final usedCoupons = <dynamic>[].obs;
  final usedCouponsLoaded = false.obs;
  final unusedCoupons = <dynamic>[].obs;
  final unusedCouponsLoaded = false.obs;
  final couponId = ''.obs;
  final infosId = 0.obs;

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

  void setInfosId(int id) {
    infosId.value = id;
  }

  /////////////
  // COMPASS //
  /////////////
  final photoPath = ''.obs;

  void setPhotoPath(String path) {
    photoPath.value = path;
  }

  //////////////////
  // TRIP DETAILS //
  //////////////////
  final anecdoteIndex = 0.obs;
  final chosenCouponImage = ''.obs;
  final chosenCouponName = ''.obs;

  void setAnecdoteIndex(int index) {
    anecdoteIndex.value = index;
  }

  void setChosenCoupon(String image, String name) {
    chosenCouponImage.value = image;
    chosenCouponName.value = name;
  }
}
